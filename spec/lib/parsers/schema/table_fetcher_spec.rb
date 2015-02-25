require 'rails_helper'

describe Parsers::Schema do
  let(:parsing) { FactoryGirl.create(:parsing) }
  let(:string) { File.read('spec/support/dirty_table.txt')}
  subject { Parsers::Schema::TableFetcher.new(string) }

  describe '#table_name' do
    subject { super().table_name }

    it { is_expected.not_to be nil }
    it { is_expected.to be_kind_of(String) }
    it { is_expected.to eq('active_admin_comments') }
  end

  describe '#splited_table' do
    subject { super().splited_table }

    it { is_expected.not_to be nil }
    it { is_expected.to be_kind_of(Array) }
    it { is_expected.to include('active_admin_comments') }
  end
end
