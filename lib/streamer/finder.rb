module Streamer
  # Finder maintains a consistent interface for all of the fact_providers
  # It allows the Stream to have a consistent finding pattern.
  class Finder
    attr_reader :fact_provider
    def initialize(provider = nil)
      @fact_provider = provider
      unless @fact_provider
        @fact_provider = Streamer::FactProviders::HashProvider.new
      end
    end

    def find(key)
      fact_provider.find(key)
    end
  end
end
