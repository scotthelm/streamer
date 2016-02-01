module Streamer
  # StreamBuilder takes a stream configuration and builds the stream defined
  # in it. StreamBuilder then performs the stream, given a document.
  class StreamBuilder
    attr_reader :config, :payload, :stream
    def initialize(config)
      @config = config
    end

    def flow(payload)
      @payload = payload
      @stream = Stream.new(payload)
      @stream.filter(function: config[:filter].first[:function])
      @stream
    end
  end
end
