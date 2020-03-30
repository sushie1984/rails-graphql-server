require 'rails_helper'

RSpec.describe Currencylayer::TargetRatesPresenter do
  let(:presenter) { described_class.new(currencylayer_rates) }
  let(:currencylayer_rates) { attributes_for(:currencylayer_response)[:quotes] }

  describe '#restructure' do
    subject(:restructure) { presenter.restructure }

    it { is_expected.to be_a(Array) }

    it 'restructures rates from currencylayer' do
      expect(restructure)
        .to include(hash_including('target' => String, 'rate' => Float))
    end

    context 'with an entry on the source rating itself' do
      let(:currencylayer_rates) { { 'USDUSD' => 1 } }

      it 'restructures rates from currencylayer' do
        expect(restructure)
          .to include(hash_including('target' => 'USD', 'rate' => 1))
      end
    end
  end
end
