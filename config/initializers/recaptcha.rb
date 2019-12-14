Recaptcha.configure do |config|
  config.site_key  = '6LfHQaIUAAAAAFU1SkuAL0pno9RVLtet6mkd9sTC' #ENV['RECAPTCHA_PUBLIC_KEY']
  config.secret_key = '6LfHQaIUAAAAALapPhWiGCcHC-sxvt0jdhAbUxUy' #ENV['RECAPTCHA_PRIVATE_KEY']
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end