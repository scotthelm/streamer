require './spec/spec_helper'
describe 'Functor' do
  before :each do
    @hash = {
      'scores' => [
        { 'month' => 'jan', 'score' => 1 },
        { 'month' => 'feb', 'score' => 2 },
        { 'month' => 'mar', 'score' => 3 }
      ],
      'sales' => [
        { 'purchase_date' => '2015-11-01', 'product' => 'prod2', amount: 100 },
        { 'purchase_date' => '2015-09-01', 'product' => 'prod1', amount: 200 },
        { 'purchase_date' => '2016-09-01', 'product' => 'prod1', amount: 300 }
      ],
      'numerator' => 2,
      'denominator' => 4
    }
  end

  it 'accepts a hash and options for initialization' do
    subject = Streamer::Functors::Functor.new(@hash, {})
    subject.wont_be_nil
  end

  it 'filters items in a list' do
    x = Streamer::Functors::Functor.new(
      @hash,
      type: 'list_filter',
      list: 'sales',
      filters: [
        {
          function: {
            type: 'gte',
            target: {
              value: '2015-10-01'
            },
            property: 'purchase_date'
          }
        },
        {
          function: {
            type: 'lte',
            target: {
              value: '2016-08-01'
            },
            property: 'purchase_date'
          }
        }
      ]
    )
    result = x.call
    result.size.must_equal 1
    result.first[:amount].must_equal 100
  end

  it 'counts items in a list' do
    Streamer::Functors::Functor.new(
      @hash,
      type: 'count', list: 'scores'
    ).call.must_equal 3
  end

  it 'averages items given a list and a property' do
    Streamer::Functors::Functor.new(
      @hash,
      type: 'average', list: 'scores', property: 'score'
    ).call.must_equal 2.0
  end

  describe 'sum' do
    it 'sums a list' do
      Streamer::Functors::Functor.new(
        @hash,
        type: 'sum', list: 'scores', property: 'score'
      ).call.must_equal 6
    end
  end

  describe 'multiply' do
    it 'multiplies a list of properties in the document' do
      Streamer::Functors::Functor.new(
        @hash,
        type: 'multiply', terms: %w(numerator denominator)
      ).call.must_equal 8
    end

    it 'fails on invalid terms' do
      err = lambda do
        Streamer::Functors::Functor.new(
          @hash,
          type: 'multiply', terms: ['numerator', ['denominator']]
        ).call
      end.must_raise RuntimeError
      err.message.must_match(/Streamer::/)
    end
  end

  describe 'subtract' do
    it 'subtracts a list of properties in the document' do
      Streamer::Functors::Functor.new(
        @hash,
        type: 'subtract', terms: %w(denominator numerator)
      ).call.must_equal 2
    end
  end

  describe 'divide' do
    it 'divides two properties in the document' do
      Streamer::Functors::Functor.new(
        @hash,
        type: 'divide', terms: %w(numerator denominator)
      ).call.must_equal 0.5
    end
  end

  describe 'lookup' do
    it 'has a fact_provider' do
      Streamer::Functors::Functor.new(
        @hash,
        type: 'lookup',
        fact: 'products.#rate',
        terms: ['#product'],
        finder: Streamer::Finder.new(
          Streamer::FactProviders::HashProvider.new({})
        )
      )
    end
  end

  describe 'least' do
    it 'finds the least number in a list' do
      Streamer::Functors::Functor.new(
        @hash,
        type: 'least',
        list: 'scores',
        property: 'score'
      ).call.must_equal 1
    end
  end

  describe 'comparisons' do
    it 'can compare a target and a value' do
      Streamer::Functors::Functor.new(
        @hash,
        type: 'gte',
        target: {
          value: 4_500
        },
        value: 4_500
      ).call.must_equal true
    end

    it 'fails if no target or value given' do
      err = lambda do
        Streamer::Functors::Functor.new(
          @hash,
          type: 'gte',
          target: {
            value: 4_500
          }
        ).call
      end.must_raise RuntimeError
      err.message.must_match(/Streamer::Functor/)
    end

    it 'handles > comparisons' do
      Streamer::Functors::Functor.new(
        @hash,
        type: 'gt',
        target: {
          value: 4_500
        },
        value: 4_501
      ).call.must_equal true
    end

    it 'handles < comparisons' do
      Streamer::Functors::Functor.new(
        @hash,
        type: 'lt',
        target: {
          value: 4_500
        },
        value: 4_499
      ).call.must_equal true
    end

    it 'handles <= comparisons' do
      Streamer::Functors::Functor.new(
        @hash,
        type: 'lte',
        target: {
          value: 4_500
        },
        value: 4_500
      ).call.must_equal true
    end
  end
end
