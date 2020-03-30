require 'rails_helper'

RSpec.describe Currency, type: :model do
  let(:attributes) { attributes_for(:currency) }

  describe '.create' do
    subject(:create) { described_class.create(attributes) }

    it 'creates an entry for a currency' do
      expect { create }.to change { described_class.count }.from(0).to(1)
    end
  end

  describe '#target_rates' do
    subject(:target_rates) { currency.target_rates }
    let(:currency) { described_class.create(attributes) }

    it { is_expected.to eq(attributes[:target_rates]) }
  end
end
