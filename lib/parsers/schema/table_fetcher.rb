module Parsers
  module Schema
    class TableFetcher
      def initialize(string)
        @string = string
      end

      def splited_table
        string.scan(/[a-z_]{1,30}/)
      end

      def table_name
        splited_table.first
      end

      private

      attr_reader :string
    end
  end
end
