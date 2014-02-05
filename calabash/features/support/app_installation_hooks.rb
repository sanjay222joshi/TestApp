require 'calabash-android/operations'

AfterConfiguration do |config|
  path1 = File.expand_path("..\\bin\\cnbcSigned.apk")
  @@app1 = Calabash::Android::Operations::Device.new(self, "#{ENV['ADB_DEVICE_ARG']}", "#{ENV["TEST_SERVER_PORT"]}", path1, test_server_path(path1))
end

Before do |scenario|
  extend Calabash::Android::Operations
   
  @@app1.reinstall_apps
  @@app1.start_test_server_in_background
  set_default_device(@@app1)
end

After do |scenario|
  extend Calabash::Android::Operations
  
  if scenario.failed?
    screenshot_embed
  end
  
  @@app1.shutdown_test_server
end