module Streamer
  module Functors
    # Lookup looks up a fact given a finder
    class Lookup < Functor
      def call
        finder = options.fetch(:finder)
        finder.find(lookup_key)
      end

      def lookup_key
        item_key = options.fetch(:terms)[0]
        options[:fact] = options.fetch(:fact).gsub('#', "#{item_key}.")
      end
    end
  end
end
