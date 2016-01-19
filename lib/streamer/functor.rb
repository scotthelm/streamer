module Streamer
  # Functor is responsible for creating the functions that the stream uses.
  class Functor
    attr_reader :payload, :options
    def initialize(payload, options)
      @payload = payload
      @options = options
    end

    def sum
      payload[options.fetch(:list)].inject(0.0) do |total, item|
        total + item[options.fetch(:property)]
      end
    end

    def multiply
      options.fetch(:terms).inject(1) do |total, item|
        total * (prop(item) || 0)
      end
    end

    def subtract
      terms = options.fetch(:terms)
      initial_prop = terms.shift
      terms.inject(prop(initial_prop).to_f) do |total, item|
        total - prop(item).to_f
      end
    end

    def divide
      return 0.0 if prop(options.fetch(:denominator)).to_f == 0.0
      num = options.fetch(:numerator)
      den = options.fetch(:denominator)
      prop(num).to_f / prop(den).to_f
    end

    private

    def call
      send(options.fetch(:type))
    end

    def prop(p)
      payload.dig(*p.split('.'))
    end
  end
end
