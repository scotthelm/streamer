module Streamer
  module Functors
    # Count provides the number of items in a list
    class Count < Functor
      def call
        list.size
      end
    end
  end
end
