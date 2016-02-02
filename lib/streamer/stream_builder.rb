module Streamer
  # StreamBuilder takes a stream configuration and builds the stream defined
  # in it. StreamBuilder then performs the stream, given a document.
  class StreamBuilder
    attr_reader :config, :payload
    def initialize(config)
      @config = config
    end

    def flow(payload)
      @payload = payload
      filter_value = config[:filter].inject(true) do |val, f|
        val &&= stream.filter(function: f[:function]).payload['filter_value']
        val
      end
      stream.payload['filter_value'] = filter_value
      stream
    end

    def stream
      @stream ||= Stream.new(payload)
    end
  end
end
