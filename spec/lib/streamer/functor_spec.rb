require './spec/spec_helper'
describe 'Functor' do
  before :each do
    @hash = {
      'scores' => [
        { 'month' => 'jan', 'score' => 1 },
        { 'month' => 'feb', 'score' => 2 },
        { 'month' => 'mar', 'score' => 3 }
      ]
    }
  end
  it 'accepts a hash and options for initialization' do
    subject = Streamer::Functor.new(@hash, {})
    subject.wont_be_nil
  end

  describe 'sum' do
    it 'sums a list' do
      Streamer::Functor.new(
        @hash,
        type: 'sum', list: 'scores', property: 'score'
      ).call.must_equal 6
    end
  end
end
