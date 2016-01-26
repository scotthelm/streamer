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

  describe 'assign_each' do
    # the '#' in the function terms means that it is applied to the item in the
    # list, and not part of the overall hash
    it 'assigns the function value to each of the items in a list' do
      @stream.payload['x-factor'] = 0.1
      @stream.assign_each(
        list: 'scores',
        property: 'rate',
        function: {
          type: 'multiply',
          terms: ['x-factor', '#score']
        }
      )
      @stream.payload['scores'][0]['rate'].must_be_within_delta 0.1, 0.00001
      @stream.payload['scores'][1]['rate'].must_be_within_delta 0.2, 0.00001
      @stream.payload['scores'][2]['rate'].must_be_within_delta 0.3, 0.00001
    end

    it 'assigns the value to each of the items in a list' do
      @stream.payload['x-factor'] = 0.1
      @stream.assign_each(
        list: 'scores',
        property: 'rate',
        value: 0.1
      )
      @stream.payload['scores'][0]['rate'].must_be_within_delta 0.1, 0.00001
      @stream.payload['scores'][1]['rate'].must_be_within_delta 0.1, 0.00001
      @stream.payload['scores'][2]['rate'].must_be_within_delta 0.1, 0.00001
    end
  end
end
