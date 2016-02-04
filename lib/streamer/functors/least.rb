module Streamer
  module Functors
    # least determines the least item in a list
    class Least < Functor
      def call
        least
      end

      def least
        vals = value(options.fetch(:list).split('.')).map do |item|
          item[options.fetch(:property)]
        end
        vals.sort.shift
      end
    end
  end
end
