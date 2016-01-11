require './spec/spec_helper'
describe 'Stream' do
  before :each do
    @subject = Streamer::Stream
    @hash = {
      'this' => 'that',
      'scores' => [
        { 'month' => 'jan', 'score' => 1 },
        { 'month' => 'feb', 'score' => 2 },
        { 'month' => 'mar', 'score' => 3 }
      ]
    }
    @stream = @subject.new(@hash)
  end

  describe 'assign' do
    it 'returns itself after assignment' do
      @stream.assign(
        property: 'assign_value',
        value: 5
      ).must_be_instance_of Streamer::Stream
    end

    it 'assigns the value to the property in the payload' do
      @stream.assign(property: 'assign_value', value: 5)
        .payload['assign_value'].must_equal 5
    end

    it 'can assign deeply nested properties' do
      @stream.assign(property: 'deeply.nested.property', value: 'w00t!')
        .payload['deeply']['nested']['property'].must_equal 'w00t!'
    end

    it 'assigns the function value to the property in the payload' do
      @stream.assign(
        property: 'total_score',
        function: {
          type: :sum,
          list: 'scores',
          property: 'score'
        }
      ).payload['total_score'].must_equal 6
    end
  end
end
