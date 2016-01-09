require './spec/spec_helper'
describe 'Streamer' do
  before :each do
    @hash = { 'this' => 'that' }
  end
  describe 'initialization' do
    it 'accepts hash in initializer' do
      Streamer::Stream.new(@hash).must_be_instance_of Streamer::Stream
    end
  end
end
