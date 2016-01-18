module Streamer
  # Finder maintains a consistent interface for all of the fact_providers
  # It allows the Stream to have a consisten finding pattern.
  class Finder
    attr_reader :fact_provider
    def initialize(provider = nil)
      if provider
        @fact_provider = provider
      else
        @fact_provider = Streamer::FactProviders::HashProvider.new
      end
    end

    def find(key)
      fact_provider.find(key)
    end
  end
end
