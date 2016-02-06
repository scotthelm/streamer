$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../support', __FILE__)

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require 'streamer'

require 'minitest/autorun'
require 'minitest/spec'
require 'pry'
