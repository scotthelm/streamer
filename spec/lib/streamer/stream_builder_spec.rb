require './spec/spec_helper'

describe Streamer::StreamBuilder do
  let(:subject) { Streamer::StreamBuilder.new(TestHashes.sb_config) }
  it 'is instantiated with a configuration' do
    subject.config.wont_be_nil
  end

  it 'filters documents given a filter' do
    subject.process(TestHashes.streamer_hash)
           .payload['filter_value'].must_equal true
  end

  it 'transforms a document given steps in the transform array' do
    subject.process(TestHashes.streamer_hash)
           .payload['sales'][0]['rate'].must_equal 0.2
  end
end
