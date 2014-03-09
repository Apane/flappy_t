module PreorderHelper

  def like_button(width = 70, show_faces = false)
    raw "<div class=\"fb-like\" data-send=\"false\" data-width=\"#{width}\" data-layout=\"box_count\" data-show-faces=\"true\"></div>"
  end
  def pin_it_button
    image_url = URI.encode("#{request.scheme}://#{request.host}#{image_path(Settings.product_image_path)}")
    raw "<a href='http://pinterest.com/pin/create/button/?url=#{encoded_root_url}&media=#{image_url}' class='pin-it-button' count-layout='vertical'><img border='0' src='//assets.pinterest.com/images/PinExt.png' title='Pin It' /></a>"
  end

  def tweet_button(caption = nil)
    caption ||= "Share on Twitter"
    tweet_text = "Play Flappy Bird with FLAPPY, the wireless toy controller. "
    querystring = {
      :url => "http://www.flappytoy.com",
      :text => tweet_text,
      :via => "flappytoy",
      :count => "vertical"
    }.map { |k, v| "#{k}=#{v}" }.join("&")

    link_to caption, "https://twitter.com/share?#{querystring}", :target => "_blank"
  end

  def video_url
    "#{Settings.video_embed_url}?" + case Settings.video_embed_url
    when /vimeo/
      'title=0&byline=0&portrait=0&autoplay=0'
    when /youtube/
      'autohide=1&showinfo=0&rel=0&autoplay=0'
    else
      ''
    end
  end

  def encoded_root_url
    raw URI.encode "#{request.scheme}://#{request.host}/preorder"
  end

  def sold_out(payment_option)
    payment_option.limit > -1 and order_count(payment_option) >= payment_option.limit
  end

  def order_count(payment_option)
    Order.where(payment_option_id: payment_option).count(:token) # count of orders that have a token from amazon and are for this payment option
  end
end
