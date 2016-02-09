module Streamer
  module Functors
    # ListFilter returns items in the list matching the filter parameters
    class ListFilter < Functor
      attr_reader :list
      def call
        @list = payload[options.fetch(:list)]
        reduce_list(options.fetch(:filters))
      end

      def reduce_list(filters)
        list.each_with_object([]) do |item, val|
          val << item if match(item, filters)
        end
      end

      def match(item, filters)
        filters.inject(true) do |val, filter|
          val &&= functor(filter[:function], item).call
          val
        end
      end
    end
  end
end
