require 'rails_helper'

describe Parsers::Schema do
  let(:parsing) { FactoryGirl.create(:parsing) }

  subject { Parsers::Schema::Parser.new(parsing.schema_attachment) }

  describe '#parse' do
    subject { super().parse }

    it { is_expected.not_to be nil }
    it { is_expected.to be_kind_of(Hash) }

    context 'item count' do
      subject { super().size }

      it { is_expected.to eq(6) }
    end
  end
end
