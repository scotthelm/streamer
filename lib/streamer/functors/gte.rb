module Streamer
  module Functors
    # Gte compares a target to a value or fuction
    class Gte < Functor
      def call
        compare(:>=)
      end
    end
  end
end
