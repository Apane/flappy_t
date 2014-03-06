class GiftMailer < ActionMailer::Base
  default :from => "flappytoy@zowpow.com"

  def notify(gift_info)
    @info = gift_info

    if @info.to_email.present?
      mail(
        :to => @info.to_email,
        :subject => "#{@info.from} has bought you a Flappy!"
      )
    end
  end

  def confirm(gift_info)
    @info = gift_info

    if @info.from_email.present?
      mail(
        :to => @info.from_email,
        :subject => "Thanks for sending Flappy to #{@info.to}"
      )
    end
  end
end