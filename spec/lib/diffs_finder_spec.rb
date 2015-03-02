require 'rails_helper'

describe DiffsFinder do
  let(:parsing) { FactoryGirl.create(:parsing) }
  let(:schema) { Parsers::Schema::Parser.new(File.new("#{Rails.root}/lib/support/schema.txt")).parse }
  let(:xml) { Parsers::Xml::Parser.new(File.new("#{Rails.root}/lib/support/LADUSA20150222D.xml")).parse }

  subject { DiffsFinder.new(schema, xml) }

  describe '#find' do
    subject { super().find }

    it { is_expected.not_to be nil }
    it { is_expected.to be_kind_of(Hash) }
    it { is_expected.to include(:xml_includes) }
    it { is_expected.to include(:schema_includes) }
    it { is_expected.to include(:schema_includes, :xml_includes) }

    context 'for some enother key' do
      let(:xml) { Parsers::Xml::Parser.new(File.new("#{Rails.root}/lib/support/2.xml")).parse }

      it { is_expected.not_to be nil }
      it { is_expected.to include(xml_includes: []) }
      it { is_expected.to include('active_admin_comments') }
      it { is_expected.to be_kind_of(Hash) }
      it { is_expected.to include(:xml_includes) }
      it { is_expected.to include(:schema_includes) }
      it { is_expected.to include(:schema_includes, :xml_includes) }

      context 'include columns' do
        subject { super()['active_admin_comments'][:columns] }

        it { is_expected.to include('first_column') }
        it { is_expected.to include('second_column') }
      end
    end
  end
end
