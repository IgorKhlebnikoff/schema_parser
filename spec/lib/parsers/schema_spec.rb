require 'rails_helper'

describe Parsers::Schema do
  let(:parsing) { FactoryGirl.create(:parsing) }
  let(:file) {  }

  subject { Parsers::Schema.new(parsing.schema_attachment) }

  describe '#parse' do
    subject { super().parse }

    it { is_expected.not_to be nil }
    it { is_expected.to be_kind_of(Hash) }
  end
end