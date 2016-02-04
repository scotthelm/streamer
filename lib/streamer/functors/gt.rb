module Streamer
  module Functors
    # Gt compares target to function or value
    class Gt < Functor
      def call
        compare :>
      end
    end
  end
end
