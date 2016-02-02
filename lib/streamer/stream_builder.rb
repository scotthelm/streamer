module Streamer
  # StreamBuilder takes a stream configuration and builds the stream defined
  # in it. StreamBuilder then performs the stream, given a document.
  class StreamBuilder
    attr_reader :config, :payload
    def initialize(config)
      @config = config
    end

    def process(payload)
      @payload = payload
      stream.payload['filter_value'] = filter_value
      transform if stream.payload['filter_value']
      stream
    end

    def transform
      config[:transform].each do |tx|
        tx.each do |k, v|
          stream.send(k, v)
        end
      end
    end

    def filter_value
      config[:filter].inject(true) do |val, f|
        val &&= stream.filter(function: f[:function]).payload['filter_value']
        val
      end
    end

    def stream
      @stream ||= Stream.new(payload)
    end
  end
end
