module Streamer
  module FactProviders
    # CSVProvider implements Finder Provider interface
    class CSVProvider
      attr_reader :path, :key

      def initialize(path)
        @path = path
      end

      def find(key)
        @key = key
        return hash_result if segments.size == 2
        return scalar_result if segments.size == 3
      end

      def segments
        key.split('.')
      end

      def hash_result
        Hash[headers.zip lines.split(',')]
      end

      def scalar_result
        hash_result[segments[2]]
      end

      def lines
        `#{processing_statement}`.strip
      end

      def headers
        @headers ||= `head -n 1 #{path}`.split(',')
      end

      def field_number(field)
        headers.index(field) + 1
      end

      def processing_statement
        segs = segments
        return unless segs.size > 1 && segs.size < 4
        <<-STMT
awk -F',' '($#{field_number(segs[0])} ~ /^#{segs[1]}$/){print $0}' #{path}
        STMT
      end
    end
  end
end
