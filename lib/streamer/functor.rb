module Streamer
  # Functor is responsible for creating the functions that the stream uses.
  class Functor
    attr_reader :payload, :options
    def initialize(payload, options)
      @payload = payload
      @options = options
    end

    def call
      send(options.fetch(:type))
    end

    def sum
      payload[options.fetch(:list)].inject(0.0) do |total, item|
        total + item[options.fetch(:property)]
      end
    end

    def multiply
      options.fetch(:terms).inject(1) do |total, item|
        unless item.is_a?(String) || item.is_a?(Numeric)
          fail "Streamer::Functor invalid term: #{item}"
        end
        val = total * (prop(item) || 0) if item.is_a? String
        val = total * item if item.is_a? Numeric
        val
      end
    end

    def subtract
      terms = options.fetch(:terms)
      initial_prop = terms.shift
      terms.inject(prop(initial_prop).to_f) do |total, item|
        total - prop(item).to_f
      end
    end

    def divide
      return 0.0 if prop(options.fetch(:denominator)).to_f == 0.0
      num = options.fetch(:numerator)
      den = options.fetch(:denominator)
      prop(num).to_f / prop(den).to_f
    end

    def lookup
      finder = options.fetch(:finder)
      finder.find(lookup_key)
    end

    def lookup_key
      item_key = options.fetch(:terms)[0]
      options[:fact] = options.fetch(:fact).gsub('#', "#{item_key}.")
    end

    { gte: :>=, lte: :<=, gt: :>, lt: :<, eq: :== }.each do |k, v|
      define_method(k) { compare(v) }
    end

    def compare(op_symbol)
      tar = target(options.fetch(:target))
      function = options[:function]
      value = options[:value]
      return functor(function).call.send(op_symbol, tar) if function
      return value.send(op_symbol, target) if value
      fail 'Streamer::Functor#gte no value or fuction given'
    end

    def group
      list = options.fetch(:list)
      group_key = options.fetch(:by)
      operand_key = options.fetch(:operand)
      operator = options.fetch(:operator).to_sym
      accumulate(list, group_key, operand_key, operator)
    end

    def accumulate(list, group_key, operand_key, operator)
      payload[list].each_with_object({}) do |item, val|
        val[item[group_key]] =
          (val[item[group_key]] || 0.0).send(operator, (item[operand_key] || 0))
      end
    end

    def member
      values = options.fetch(:properties).map do |pk|
        value(pk.split('.'))
      end.flatten
      (values & options.fetch(:facts)).size > 0
    end

    def value(pk, data = payload)
      return data if pk.size == 0
      data = data[pk.shift]
      return data.map { |x| value(pk, x) } if data.is_a? Array
      value(pk, data)
    end

    private

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
  end
end
