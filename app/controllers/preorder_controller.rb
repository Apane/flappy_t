class PreorderController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :ipn


  def index
  end

  def checkout
    @gift = (params[:gift] == "1")
    @error = (params[:e] == "0")
  end

  def aboutus
  end

  def faq
  end

  def flappystory
  end

  def prefill
    if params[:from_email].present?

      @user = User.find_or_create_by(:email => params[:from_email])

      if Settings.use_payment_options
        payment_option_id = params['payment_option']
        raise Exception.new("No payment option was selected") if payment_option_id.nil?
        payment_option = PaymentOption.find(payment_option_id)
        price = payment_option.amount
      else
        price = Settings.price
      end
      price = calculate_price(price)

      @order = Order.prefill!(
        :name => Settings.product_name,
        :price => price,
        :user_id => @user.id,
        :payment_option => payment_option
      )

      # Check for gift settings,
      # sending email notification if valid
      if params[:gift].present? &&
         (params[:from_email].present? && params[:to_email].present?)
        info = GiftInfo.new
        info.from_name  = params[:from_name]
        info.from_email = params[:from_email]
        info.to_name    = params[:to_name]
        info.to_email   = params[:to_email]
        info.note       = params[:note]
        info.order_id   = @order.id
        info.save!
      end

      # This is where all the magic happens. We create a multi-use token with Amazon, letting us charge the user's Amazon account
      # Then, if they confirm the payment, Amazon POSTs us their shipping details and phone number
      # From there, we save it, and voila, we got ourselves a preorder!
      port = Rails.env.production? ? "" : ":3000"
      callback_url = "#{request.scheme}://#{request.host}#{port}/preorder/postfill"
      redirect_to AmazonFlexPay.multi_use_pipeline(
        @order.uuid,
        callback_url,
       :transaction_amount       => @order.price.to_f,
       :global_amount_limit      => @order.price.to_f + Settings.charge_limit,
       :collect_shipping_address => "False",
       :payment_reason           => Settings.payment_description
      )
  else
    redirect_to preorder_checkout_url(:e => 0)
  end
end

  def postfill
    unless params[:callerReference].blank?
      @order = Order.postfill!(params)
    end
    # "A" means the user cancelled the preorder before clicking "Confirm" on Amazon Payments.
    if params['status'] != 'A' && @order.present?
      send_emails!(@order)
      redirect_to :action => :share, :uuid => @order.uuid
    else
      redirect_to root_url
    end
  end

  def share
    @order = Order.find_by(:uuid => params[:uuid])
  end

  def ipn
  end

  private

  def calculate_price(unit_price)
    units    = params[:quantity].try(:to_i) || 0 # default to 0
    locale   = params[:shippingoptions] || "United States"
    shared   = params[:shared] == "1"
    shipping = (shared && locale == "United States") ?
      0.0 : Order::SHIPPING_COST[locale]
    (unit_price.to_f * units) + shipping
  end

  def send_emails!(order)
    info = order.gift_info

    if info.present?
      GiftMailer.confirm(info).deliver!
      GiftMailer.notify(info).deliver!
    end
  end
end
