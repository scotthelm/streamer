module Streamer
  module Functors
    # Eq compares target to function or value
    class Eq < Functor
      def call
        compare :==
      end
    end
  end
end
