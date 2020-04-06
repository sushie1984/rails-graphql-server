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

  describe '.upsert_for!' do
    subject(:upsert_for) do
      described_class.upsert_for!(base: base,
                                  foreign_rates: foreign_rates,
                                  published_at: published_at)
    end
    let(:base) { attributes[:base] }
    let(:foreign_rates) { attributes[:foreign_rates] }
    let(:published_at) { attributes[:published_at] }
    let(:attributes) { FactoryBot.attributes_for(:currency) }

    it 'upserts currency' do
      expect { upsert_for }
        .to change { Currency.where(base: base).count }
        .from(0)
        .to(1)
    end

    context 'when currency for that day already exists' do
      let!(:currency) { FactoryBot.create(:currency) }
      let(:base) { currency.base }
      let(:foreign_rates) { currency.foreign_rates }
      let(:published_at) { currency.published_at.end_of_day }

      it 'does not persist another entry for this currency' do
        expect { upsert_for }
          .not_to change { Currency.where(base: base).count }
      end

      context 'with updated foreign_rates' do
        let(:foreign_rates) { [{ 'currency' => 'USD', 'rate' => 1.1 }] }
        let(:outdated_foreign_rates) { currency.foreign_rates }

        it 'updates outdated foreign_rates of currency entry' do
          expect { upsert_for }
            .to change { Currency.find_by(base: base).foreign_rates }
            .from(outdated_foreign_rates)
            .to(foreign_rates)
        end
      end
    end
  end
end
