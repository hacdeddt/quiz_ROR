Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?


  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = true
  config.assets.precompile += %w( *.erb application.scss application.js *.png *.jpg *.ico *.gif)
  # cái này nhớ là phải là application.scss và application.js, vì nó sẽ biên dịch 2 cái này, trong
  # 2 cái này lại bao gồm tất cả các file css và js con. Vì vậy, nếu để *.scss và *.js nó sẽ biên
  # dịch các file 2 lần, như thế sẽ lỗi. Nhớ nhé
  # lệnh chạy server trong môi trường production kèm theo cả SSL:
  #RAILS_SERVE_STATIC_FILES=true RAILS_ENV=production bundle exec rails s -b "ssl://0.0.0.0:3000?key=quizhub.com2-key.pem&cert=quizhub.com2.pem"
  # à quên, nhớ là trước khi chạy server phải biên dịch các file assets trước nhé.
  # lệnh này để xóa thư mục assets trong public: rails assets:clobber
  # lệnh này để biên dịch lại: RAILS_ENV=production rails assets:precompile
  # thêm link hướng dẫn tạo rails secret và thêm: https://gist.github.com/rwarbelow/40bd72b2aee8888d6d91

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "quiz_#{Rails.env}"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # remove class field_with_errors cho khong loi giao dien
  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    html_tag.html_safe
  end

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true

    config.action_mailer.smtp_settings = {
      :address            => 'smtp.gmail.com',
      :port               => 587,
      :domain             => 'gmail.com',
      :authentication     => :plain,
      :user_name          => 'hequanlysinhvienact@gmail.com',
      :password           => ENV['GMAIL_PASSWORD'],
      :enable_starttls_auto => true
    }

    # SSL protocol
    config.force_ssl = true

    # Redis
    config.cache_store = :redis_cache_store, {driver: :hiredis, url: "redis://quizhub.com:6379/0" }
    config.action_controller.perform_caching = true
    config.session_store :cache_store, key: "_quiz_session"
end
