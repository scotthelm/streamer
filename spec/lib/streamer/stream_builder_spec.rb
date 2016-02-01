require './spec/spec_helper'

describe Streamer::StreamBuilder do
  let(:subject) { Streamer::StreamBuilder.new(TestHashes.sb_config) }
  it 'is instantiated with a configuration' do
    subject.config.wont_be_nil
  end

  it 'filters documents given a filter' do
    subject.flow(TestHashes.streamer_hash)
           .payload['filter_value'].must_equal false
  end
end
