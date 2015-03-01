class DiffsFinder
  def initialize(schema, xml)
    @schema = schema
    @xml = xml
  end

  def find
    keys.inject(default_shape) do |differences, key|
      if schema.has_key?(key) && xml.has_key?(key)
        differences.merge!(key => { columns: schema[key] | xml[key] })
      elsif !schema.has_key?(key) && xml.has_key?(key)
        differences[:xml_includes] << { key => xml[key] }
      elsif schema.has_key?(key) && !xml.has_key?(key)
        differences[:schema_includes] << { key => schema[key] }
      end
      differences
    end
  end

  private

  attr_reader :schema, :xml

  def keys
    (schema.keys | xml.keys)
  end

  def default_shape
    { xml_includes: [], schema_includes: [] }
  end
end
