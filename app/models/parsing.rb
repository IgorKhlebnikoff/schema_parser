class Parsing < ActiveRecord::Base
  has_attached_file :schema_attachment
  has_attached_file :xml_attachment

  validates :name, presence: true
  validates_attachment_content_type :schema_attachment, content_type: 'text/plain'
  validates_attachment_content_type :xml_attachment, content_type: /xml/

  serialize :snapshot, Hash

  def parse!
    schema = Parsers::Schema::Parser.new(schema_attachment).parse
    xml = Parsers::Xml::Parser.new(xml_attachment).parse
    update(snapshot: {
      schema: schema,
      xml:    xml,
      diff:   find_diff(schema, xml)
    })
  end

  def diff_tables_in_xml
    snapshot[:diff][:xml_includes]
  end

  def diff_tables_in_schema
    snapshot[:diff][:schema_includes]
  end

  def existing_tables_columns_diff
    snapshot[:diff].reject { |key, value| key == :xml_includes || key == :schema_includes }
  end

  def diffs_in_tables?
    existing_tables_columns_diff.any?
  end

  def diffs_in_schema?
    diff_tables_in_schema.any?
  end

  def diffs_in_xml?
    diff_tables_in_xml.any?
  end

  private

  def find_diff(schema, xml)
    DiffsFinder.new(schema, xml).find
  end
end
