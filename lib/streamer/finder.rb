module Streamer
  # Finder maintains a consistent interface for all of the fact_providers
  # It allows the Stream to have a consistent finding pattern.
  class Finder
    extend Forwardable
    attr_reader :fact_provider
    delegate find: :fact_provider

    def initialize(provider = nil)
      return @fact_provider = provider if provider
      @fact_provider = Streamer::FactProviders::HashProvider.new
    end
  end
end
