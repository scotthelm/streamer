module Streamer
  module FactProviders
    # HashProvider implements the Finder Provider interface
    class HashProvider
      attr_reader :data
      def initialize(data = nil)
        if data
          @data = data
        else
          @data = {}
        end
      end

      def find(key)
        keys = key.split('.').map(&:to_sym)
        data.dig(*keys)
      end
    end
  end
end
