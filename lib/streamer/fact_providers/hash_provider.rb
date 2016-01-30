module Streamer
  module FactProviders
    # HashProvider implements the Finder Provider interface
    class HashProvider
      attr_reader :data
      def initialize(data = nil)
        @data = data || {}
      end

      def find(key)
        string_keys = key.split('.')
        sym_keys = key.split('.').map(&:to_sym)
        data.dig(*string_keys) || data.dig(*sym_keys)
      end
    end
  end
end
