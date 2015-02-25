require 'rails_helper'

describe Parsers::Schema do
  let(:parsing) { FactoryGirl.create(:parsing) }
  let(:string) { File.read('spec/support/dirty_table.txt')}
  subject { Parsers::Schema::ColumnsFetcher.new(string) }

  describe '#columns' do
    subject { super().columns }

    it { is_expected.not_to be nil }
    it { is_expected.to be_kind_of(Array) }
    it { is_expected.to eq(["resource_id", "resource_type", "author_id", "author_type", "body", "created_at", "updated_at", "namespace"]) }
  end
end
