require 'spec_helper'
describe Streamer::FactProviders::YamlProvider do
  before :each do
    yaml = <<-yaml
    years:
      current: 2016
    yaml
    @provider = Streamer::FactProviders::YamlProvider.new(yaml: yaml)
  end
  it 'should have a find method' do
    @provider.must_respond_to(:find)
  end

  it 'should find an element by key' do
    @provider.find('years.current').must_equal 2016
  end

  it 'accepts a yml file for data' do
    @provider = Streamer::FactProviders::YamlProvider.new(
      path: File.expand_path('../../../../support/test.yml', __FILE__).to_s
    ).find('products.product1.product_group').must_equal 1
  end
end
