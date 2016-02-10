module Streamer
  module Functors
    # Sum sums the list using the property provided
    class Sum < Functor
      def call
        list.inject(0.0) do |total, item|
          total + item[options.fetch(:property)]
        end
      end

    end
  end
end
