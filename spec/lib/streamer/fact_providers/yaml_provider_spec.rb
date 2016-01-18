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
end
