module Streamer
  # Functor is responsible for creating the functions that the stream uses.
  class Functor
    attr_reader :payload, :options
    def initialize(payload, options)
      @payload = payload
      @options = options
    end

    def call
      send(options.fetch(:type))
    end

    def sum
      payload[options.fetch(:list)].inject(0.0) do |total, item|
        total + item[options.fetch(:property)]
      end
    end
  end
end
