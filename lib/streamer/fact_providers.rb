require 'streamer/fact_providers/yaml_provider'
require 'streamer/fact_providers/hash_provider'
require 'streamer/fact_providers/csv_provider'

module Streamer
  # FactProviders are used by finders to find facts
  module FactProviders
    # Interface for FactProviders : for use by other libs
    module Interface
      def find(key)
      end
    end
  end
end
