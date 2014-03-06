class GiftMailer < ActionMailer::Base
  default :from => "flappytoy@zowpow.com"

  def notify(gift_info)
    @info = gift_info

    if @info.to_email.present?
      mail(
        :to => @info.to_email,
        :subject => "#{@info.from} has bought you a Flappy!",
        :body => <<-EOS.strip
Hi #{@info.to},

You're getting this email because someone has bought you a Flappy as a gift.  We're currently in funding mode, but look for an order confirmation email from us once the project is backed!

If you'd like to get a Flappy for someone else as well, you can preorder at our site - http://flappytoy.herokuapp.com.

Thanks,
The Flappy Team
        EOS
      )
    end
  end
end