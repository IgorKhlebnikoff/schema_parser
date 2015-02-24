module Parsers
  module Schema
    class Parser
      def initialize(file)
        @file_data = read_file_data(file)
      end

      def parse
        (1..times).inject({}) do |tables, _|
          dirty_table = string_between(file_data, 'create_table "', 'end')
          table_name = fetch_tables(dirty_table)
          columns = fetch_columns(dirty_table)
          @file_data = file_data.sub("create_table \"#{dirty_table}end", '')
          tables.merge!(table_name => columns)
          tables
        end
      end

      private

      attr_reader :file_data

      def read_file_data(file)
        File.open(file.path).read
      end

      def times
        file_data.scan(/ create_table "/).size
      end

      def fetch_tables(string)
        Parsers::Schema::TableFetcher.new(string).table_name
      end

      def fetch_columns(string)
        Parsers::Schema::ColumnsFetcher.new(string).columns
      end

      def string_between(string, start_at, end_at)
        start_index = string.index(start_at)
        start_index += start_at.length
        length = string.index(end_at, start_index).to_i - start_index
        string[start_index, length]
      end
    end
  end
end
