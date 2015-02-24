module Parsers
  class Base
    def initialize(file)
      @file = file
      read_file_data(file)
    end

    def parse
      raise(NotImplementedError, "#parse is not overriden in #{self.class.name}")
    end

    private

    attr_reader :file_data

    def read_file_data(file)
      @file_data = File.open(file.path).read
    end
  end
end
