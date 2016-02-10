module Streamer
  module Functors
    # least determines the least item in a list
    class Least < Functor
      def call
        vals = list.map do |item|
          item[options.fetch(:property)]
        end
        vals.sort.shift
      end
    end
  end
end
