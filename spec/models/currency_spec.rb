require 'rails_helper'

RSpec.describe Currency, type: :model do
  let(:attributes) { attributes_for(:currency) }

  describe '.create' do
    subject(:create) { described_class.create(attributes) }

    it 'creates an entry for a currency' do
      expect { create }.to change { described_class.count }.from(0).to(1)
    end
  end

  describe '#foreign_rates' do
    subject(:foreign_rates) { currency.foreign_rates }
    let(:currency) { described_class.create(attributes) }

    it { is_expected.to eq(attributes[:foreign_rates]) }
  end
end
