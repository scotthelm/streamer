module Streamer
  module Functors
    # Functor is responsible for creating the functions that the stream uses.
    class Functor
      attr_reader :payload, :options
      def initialize(payload, options)
        @payload = payload
        @options = options
      end

      def call
        Module.const_get(class_name).new(payload, options).call
      end

      def class_name
        "Streamer::Functors::#{type_name}"
      end

      def type_name
        options.fetch(:type).to_s.split('_').map(&:capitalize).join
      end

      private

      def compare(op)
        fail 'Streamer::Functor::Compare no comparison' unless valid_compare
        compare_function(op) || compare_value(op) || compare_property(op)
      end

      def valid_compare
        option_value || function || property
      end

      def compare_function(op_symbol)
        return unless function
        functor(function).call.send(op_symbol, target(options.fetch(:target)))
      end

      def compare_value(op_symbol)
        return if option_value.nil?
        option_value.send(op_symbol, target(options.fetch(:target)))
      end

      def compare_property(op_symbol)
        return if property.nil?
        prop(property).send(op_symbol, target(options.fetch(:target)))
      end

      def numerify(terms)
        terms.map do |t|
          val = prop(t) if t.is_a? String
          val = t if t.is_a? Numeric
          val
        end
      end

      def prop(p)
        payload.dig(*p.split('.'))
      end

      def functor(function_hash, pl = payload)
        Functor.new(pl, function_hash)
      end

      def target(options)
        return options[:value] if options[:value]
        return functor(options[:function]).call if options[:function]
      end

      def value(pk, data = payload)
        return data if pk.size == 0
        data = data[pk.shift]
        return data.map { |x| value(pk, x) } if data.is_a? Array
        value(pk, data)
      end

      def function
        options[:function]
      end

      def option_value
        options[:value]
      end

      def property
        options[:property]
      end

      def list_definition
        options.fetch(:list)
      end

      def list
        return list_from_value unless list_definition[:value].nil?
        return list_from_function unless list_definition[:function].nil?
        fail 'Streamer::Functors - no list given'
      end

      def list_from_value
        payload[list_definition[:value]]
      end

      def list_from_function
        functor(list_definition[:function]).call
      end
    end
  end
end
