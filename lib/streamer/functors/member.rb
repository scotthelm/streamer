module Streamer
  module Functors
    # Member determines if the properties provided are members of the facts
    class Member < Functor
      def call
        member
      end

      def member
        values = options.fetch(:properties).map do |pk|
          value(pk.split('.'))
        end.flatten
        (values & options.fetch(:facts)).size > 0
      end
    end
  end
end
