require 'rails_helper'

RSpec.describe Currencylayer::RatingQuotes do
  let(:quotes) do
    described_class.new(source, update_rates, published_at, target_currencies)
  end
  let(:source) { currency[:source] }
  let(:update_rates) { currency[:target_rates] }
  let(:published_at) { currency[:published_at] }
  let(:currency) { attributes_for(:currency) }
  let(:target_currencies) { update_rates.map { |entry| entry['target'] } }

  describe '#upsert' do
    subject(:upsert) { quotes.upsert }

    it 'upserts currency' do
      expect { upsert }
        .to change { Currency.where(source: source).count }
        .from(0)
        .to(1)
    end

    context 'when currency already exists' do
      before do
        upsert
      end

      it 'does not persist another entry for this currency' do
        expect { upsert }
          .not_to change { Currency.where(source: source).count }
      end

      context 'with a newer rates' do
        let(:fixed_update_rates) { [{ 'target' => 'USD', 'rate' => 1.1 }] }
        let(:upsert_fixed_rates) do
          described_class.new(source,
                              fixed_update_rates,
                              published_at,
                              target_currencies).upsert
        end

        it 'updates target_rates of currency entry' do
          expect { upsert_fixed_rates }
            .to change { Currency.find_by(source: source).target_rates }
            .from(update_rates)
            .to(fixed_update_rates)
        end
      end
    end
  end
end
