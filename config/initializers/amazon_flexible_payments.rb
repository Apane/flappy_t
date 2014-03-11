AmazonFlexPay.access_key = ENV["AWS_ACCESS_KEY_ID"]
AmazonFlexPay.secret_key = ENV["AWS_SECRET_ACCESS_KEY"]
AmazonFlexPay.go_live! if Rails.env.production?