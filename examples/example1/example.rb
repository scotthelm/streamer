#!/usr/bin/env ruby
require 'bundler/setup'
require 'streamer'
require 'csv'
require 'pry'

# create a base document to house the sales data
sales_numbers = {
  'name' => 'example sales filtering and calculation',
  'sales' => []
}

# load sales data from a csv and place it into the document
data_file_path = File.join(__dir__, 'data.csv')
CSV.foreach(data_file_path, headers: true) do |row|
  sales_numbers['sales'] << row.to_hash
end

# configure a new stream, loading the configuration from a file
config_file_path = File.join(__dir__, 'sb_config.yml')
sb = Streamer::StreamBuilder.new(YAML.load_file(config_file_path))

# process the data document using the configured stream
sb.process(sales_numbers)

# output the results to stdout
sb.payload['summary']['sales_by_product'].each do |k, v|
  printf "%-20s %d\n", k, v
end
