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
        "Streamer::Functors::#{options.fetch(:type).capitalize}"
      end

      private

      def compare(op_symbol)
        tar = target(options.fetch(:target))
        function = options[:function]
        value = options[:value]
        return functor(function).call.send(op_symbol, tar) if function
        return value.send(op_symbol, target) unless value.nil?
        fail 'Streamer::Functor#gte no value or fuction given'
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

      def functor(function_hash)
        Functor.new(payload, function_hash)
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
    end
  end
end
