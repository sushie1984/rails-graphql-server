require 'rails_helper'

RSpec.describe Currencylayer::RatingQuotes do
  let(:quotes) do
    described_class.new(base, foreign_rates_update, published_at)
  end
  let(:base) { currency[:base] }
  let(:foreign_rates_update) { currency[:foreign_rates] }
  let(:published_at) { currency[:published_at] }
  let(:currency) { attributes_for(:currency) }

  describe '#upsert' do
    subject(:upsert) { quotes.upsert }

    it 'upserts currency' do
      expect { upsert }
        .to change { Currency.where(base: base).count }
        .from(0)
        .to(1)
    end

    context 'when currency already exists' do
      before do
        upsert
      end

      it 'does not persist another entry for this currency' do
        expect { upsert }
          .not_to change { Currency.where(base: base).count }
      end

      context 'with a newer rates' do
        let(:newer_foreign_rates_update) do
          [{ 'target' => 'USD', 'rate' => 1.1 }]
        end
        let(:upsert_newer_foreign_rates) do
          described_class.new(base,
                              newer_foreign_rates_update,
                              published_at).upsert
        end

        it 'updates target_rates of currency entry' do
          expect { upsert_newer_foreign_rates }
            .to change { Currency.find_by(base: base).foreign_rates }
            .from(foreign_rates_update)
            .to(newer_foreign_rates_update)
        end
      end
    end
  end
end
