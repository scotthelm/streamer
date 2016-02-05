module Streamer
  module Functors
    # Count provides the number of items in a list
    class Count < Functor
      def call
        payload[options.fetch(:list)].size
      end
    end
  end
end
