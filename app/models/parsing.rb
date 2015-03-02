class Parsing < ActiveRecord::Base
  has_attached_file :schema_attachment
  has_attached_file :xml_attachment

  validates :name, presence: true
  validates_attachment_content_type :schema_attachment, content_type: 'text/plain'
  validates_attachment_content_type :xml_attachment, content_type: 'text/xml'

  serialize :snapshot, Hash

  def parse
    update(snapshot: {
        schema: Parsers::Schema::Parser.new(schema_attachment).parse,
        xml:    Parsers::Xml::Parser.new(xml_attachment).parse
    })
  end

  def diff
    snapshot[:schema].diff(snapshot[:xml])
  end
end
