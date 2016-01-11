# Streamer is the module that is responsible for pushing data through the
# pipe
module Streamer
  # Stream is the object that is responsible for mutating the data passed to it
  class Stream
    attr_reader :payload
    def initialize(hash)
      @payload = hash
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

    def functor(options = {})
      Functor.new(payload, options)
    end
  end
end
