# Streamer is the module that is responsible for pushing data through the
# pipe
module Streamer
  # Stream is the object that is responsible for mutating the data passed to it
  class Stream
    attr_reader :payload
    def initialize(hash)
      @payload = hash
    end
  end
end
