require './spec/spec_helper'
describe 'Functor' do
  before :each do
    @hash = {
      'scores' => [
        { 'month' => 'jan', 'score' => 1 },
        { 'month' => 'feb', 'score' => 2 },
        { 'month' => 'mar', 'score' => 3 }
      ],
      'numerator' => 2,
      'denominator' => 4
    }
  end
  it 'accepts a hash and options for initialization' do
    subject = Streamer::Functors::Functor.new(@hash, {})
    subject.wont_be_nil
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
end
