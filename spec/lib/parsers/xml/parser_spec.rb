require 'rails_helper'

describe Parsers::Xml::Parser do
  let(:parsing) { FactoryGirl.create(:parsing) }

  subject { Parsers::Xml::Parser.new(parsing.xml_attachment) }

  describe '#parse' do
    subject { super().parse }

    it { is_expected.to be }
    it { is_expected.to be_kind_of(Hash) }
  end
end
