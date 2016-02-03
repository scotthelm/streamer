#!/usr/bin/env ruby
require 'bundler/setup'
require 'streamer'
require 'csv'
require 'pry'

sales_numbers = {
  'date' => '2016-02-02',
  'sales' => []
}

data_file_path = File.join(__dir__, 'data.csv')
CSV.foreach(data_file_path, headers: true) do |row|
  sales_numbers['sales'] << row.to_hash
end

config_file_path = File.join(__dir__, 'sb_config.yml')
sb = Streamer::StreamBuilder.new(YAML.load_file(config_file_path))
sb.process(sales_numbers)
sb.payload['summary']['sales_by_product'].each do |k, v|
  printf "%-20s %d\n", k, v
end
