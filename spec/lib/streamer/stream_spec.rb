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
      ],
      'sales' => [
        { 'product' => 'product1', 'units' => 100, 'amount' => 280 },
        { 'product' => 'product2', 'units' => 300, 'amount' => 2800 },
        { 'product' => 'product3', 'units' => 200, 'amount' => 1700 }
      ]
    }
    @stream = @subject.new(@hash)
    @facts = {
      'products' => {
        'product1' => { 'rate' => 0.1, 'group' => 'category 3' },
        'product2' => { 'rate' => 0.2, 'group' => 'category 1' },
        'product3' => { 'rate' => 0.3, 'group' => 'category 2' }
      }
    }
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
      @stream.payload['scores'][1]['rate'].must_be_within_delta 0.2, 0.00001
    end

    it 'assigns the value to each of the items in a list' do
      @stream.payload['x-factor'] = 0.1
      @stream.assign_each(
        list: 'scores',
        property: 'rate',
        value: 0.1
      )
      @stream.payload['scores'][1]['rate'].must_be_within_delta 0.1, 0.00001
    end
  end

  describe 'fact_finder' do
    before :each do
      @stream.finder = Streamer::Finder.new(
        Streamer::FactProviders::HashProvider.new(@facts)
      )
    end

    it 'can assign values from lookup values' do
      @stream.assign_each(
        list: 'sales',
        property: 'rate',
        function: {
          type: 'lookup',
          fact: 'products.#rate',
          terms: ['#product'],
          finder: @stream.finder
        }
      )
      [1, 2, 3].each do |x|
        @stream.payload['sales'][x - 1]['rate']
          .must_be_within_delta (0.1 * x), 0.00001
      end
    end
  end

  describe 'filters' do
    it 'must assign bool filter_value key to payload passing value target' do
      @stream.filter(
        function: {
          type: 'gte',
          target: {
            value: 4_500
          },
          function: {
            type: 'sum',
            list: 'sales',
            property: 'amount'
          }
        }
      ).payload['filter_value'].must_equal true
    end

    it 'must assign bool filter_value key to payload passing function target' do
      @stream.filter(
        function: {
          type: 'eq',
          target: {
            function: {
              type: 'sum',
              list: 'sales',
              property: 'amount'
            }
          },
          function: {
            type: 'sum',
            list: 'sales',
            property: 'amount'
          }
        }
      ).payload['filter_value'].must_equal true
    end
  end

  describe 'group' do
    it 'must group a list by a key, using a function' do
      @stream.assign(
        property: 'sales_summary.amount_by_product',
        function: {
          type: 'group',
          list: 'sales',
          by: 'product',
          operator: '+',
          operand: 'amount'
        }
      ).payload['sales_summary']['amount_by_product']['product1'].must_equal 280
    end
  end
end
