module Parsers
  class Schema < Base
    def parse
      @h = Hash.new
      length = @file_data.scan(/ create_table "/).length
      length.times do
        string = fetch_tables
        table = fetch_columns
        @h["#{string}"] = table
      end
      @h
    end

    private

    def fetch_tables
      table = string_between(file_data, 'create_table "', 'end')
      string = table.scan(/([a-z_]{1,30})/)
      string = string[0][0]
      string
    end

    def fetch_columns
      table = string_between(file_data, 'create_table "', 'end')
      @file_data = @file_data.gsub!("create_table \"#{table}end", '')
      table = table.scan(/("[a-z_]{1,30})/)
      table.map{|i| i[0] = i[0].gsub('"', '')}
      table.flatten
    end

    def string_between(string, start_at, end_at)
      start_index = string.index(start_at)
      start_index += start_at.length
      length = string.index(end_at, start_index).to_i - start_index
      string[start_index, length]
    end
  end
end
