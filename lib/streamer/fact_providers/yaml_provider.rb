require 'yaml'
module Streamer
  module FactProviders
    # YamlProvider provides data from a yaml file
    class YamlProvider
      extend Forwardable
      attr_reader :data
      delegate find: :provider

      def initialize(path: nil, yaml: nil)
        load_file(path) if path
        load_yaml(yaml) if yaml
      end

      def load_file(path)
        @data = YAML.load(File.read(path))
      end

      def load_yaml(yaml)
        @data = YAML.load(yaml)
      end

      def provider
        @provider ||= HashProvider.new(data)
      end
    end
  end
end
