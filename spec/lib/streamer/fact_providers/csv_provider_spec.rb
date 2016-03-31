require 'spec_helper'
describe Streamer::FactProviders::CSVProvider do
  let :file_path do
    File.expand_path('../../../../support/csv_provider.csv', __FILE__).to_s
  end

  before :all do
    @p = Streamer::FactProviders::CSVProvider.new(file_path)
  end

  it 'should have a find method' do
    @p.must_respond_to(:find)
  end

  it 'returns a hash given a key with two segments' do
    @p.find('id.1').must_be_kind_of Hash
  end

  it 'returns a value given key with 3 segments' do
    @p.find('id.1.first_name').must_equal 'John'
  end

  it 'returns an array of headers if asked' do
    @p.headers.must_be_kind_of Array
  end

  it 'returns the field number of a header' do
    @p.field_number('id').must_equal 1
  end
end
