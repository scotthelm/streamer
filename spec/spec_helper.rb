if ENV['GNTP_NOTIFY']
  require 'simplecov'
  SimpleCov.start
else
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'minitest/autorun'
require 'minitest/spec'
require 'pry'
require 'streamer'
