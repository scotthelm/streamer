# Streamer is the module that is responsible for pushing data through the
# pipe
module Streamer
  # Stream is the object that is responsible for mutating the data passed to it
  class Stream
    attr_reader :payload
    attr_accessor :finder
    def initialize(hash)
      @payload = hash
    end

    def filter(function:)
      assign(property: 'filter_value', value: functor(function).call)
    end

    def assign(property:, value: nil, function: nil)
      assign_property(
        structure: payload,
        properties: property.to_s.split('.'),
        value: value,
        function: function
      )
      self
    end

    def assign_property(structure:, properties:, value: nil, function: nil)
      properties.each_with_index do |prop, index|
        if index == properties.size - 1
          structure[prop] = value if value
          structure[prop] = functor(function).call if function
        else
          structure[prop] = {} unless structure[prop]
          structure = structure[prop]
        end
      end
    end

    def assign_each(list:, property:, value: nil, function: nil)
      payload.dig(*list.split('.')).each do |item|
        item[property] = value if value
        item[property] = functor(replace_terms(item, function)).call if function
      end
      self
    end

    def replace_terms(item, function_hash)
      newfunc = Marshal.load(Marshal.dump(function_hash))
      newfunc[:terms] = newfunc[:terms].map do |t|
        if t.is_a?(String) && t.start_with?('#')
          t[0] = '' # remove the '#'
          item.dig(*t.split('.'))
        else
          t
        end
      end
      newfunc
    end

    def functor(options = {}, pl = payload)
      Functor.new(pl, options)
    end
  end
end
