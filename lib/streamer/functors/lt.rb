module Streamer
  module Functors
    # Lt compares target to function or value
    class Lt < Functor
      def call
        compare :<
      end
    end
  end
end
