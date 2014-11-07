
Myflix::Application.configure do

  config.cache_classes = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { host: 'localhost:5000' }

  config.active_support.deprecation = :log

  config.assets.compress = false

  config.assets.debug = true

  config.eager_load = false

  # The following configuration results in this error message, even after following the stated gem installations:
    # You must install the ruby-growl or the ruby_gntp gem to use Growl notification: `gem install ruby-growl` or `gem install ruby_gntp` (UniformNotifier::NotificationError)
  # Accordingly, cannot use bullet gem functionality.

  # config.after_initialize do
  #   Bullet.enable = true
  #   Bullet.alert = true
  #   Bullet.bullet_logger = true
  #   Bullet.console = true
  #   Bullet.growl = true
  #   Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
  #                   :password => 'bullets_password_for_jabber',
  #                   :receiver => 'your_account@jabber.org',
  #                   :show_online_status => true }
  #   Bullet.rails_logger = true
  #   Bullet.bugsnag = true
  #   Bullet.airbrake = true
  #   Bullet.add_footer = true
  #   Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
  # end
end
