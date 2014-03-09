# config/initializers/social_buttons.rb
SocialButtons.config do |social|
  social.tweet do |tweet|
    tweet.default_options = {
      :via => "myself",
      :text => "Play Flappy Bird with FLAPPY, the wireless toy controller.  http://www.flappytoy.com @flappytoy",
      :url => "http://www.flappytoy.com"
    }
  end
end
