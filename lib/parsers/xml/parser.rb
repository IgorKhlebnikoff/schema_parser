module Parsers
  module Xml
    class Parser
      def initialize(file)
        @file = file
        @hashed_data = hashed_data
        @tables = {}
      end

      def parse
        fetch_tables(hashed_data)
      end

      private

      attr_reader :file

      def fetch_tables(hash)
        hash.each do |key, value|
          internal_hash, columns = fetch_columns(value)
          merge(key, columns)
          if internal_hash.size == 1
            hash = fetch_from_collection(internal_hash)
            fetch_tables(hash)
          else
            fetch_tables(internal_hash)
          end
        end
      end

      def fetch_columns(hash)
        internal_hash = hash.select { |key, value| value.kind_of?(Hash) }
        [internal_hash, hash.reject { |key, value| value.kind_of?(Hash) }.keys.map(&:underscore)]
      end

      def fetch_from_collection(hash)
        hash.inject({}) { |result, (key, value)| result.merge!({ key => value.values.first.first }); result }
      end

      def file_data
        File.open(file.path).read
      end

      def hashed_data
        @hashed_data ||= Hash.from_xml(file_data)
      end

      def merge(key, columns)
        @tables.merge!(key.underscore => columns)
      end
    end
  end
end
