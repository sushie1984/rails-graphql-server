require 'rails_helper'

RSpec.describe Currencylayer::Quotes do
  let(:quotes) { described_class.new(source, currencylayer_quotes ) }
  let(:source) { response[:source] }
  let(:currencylayer_quotes) { response[:quotes] }
  let(:response) { attributes_for(:currencylayer_response) }

  describe '#to_foreign_rates' do
    subject(:to_foreign_rates) { quotes.to_foreign_rates }

    it { is_expected.to be_a(Array) }

    it 'convert rates to currency foreign_rate structure' do
      expect(to_foreign_rates)
        .to include(hash_including('currency' => String, 'rate' => Float))
    end

    context 'with focus on foreign rating entry' do
      let(:source) { 'USD' }
      let(:currencylayer_quotes) { { 'USDUSD' => 1 } }

      it 'sanitizes converted currency entry' do
        expect(to_foreign_rates)
          .to include(hash_including('currency' => 'USD', 'rate' => 1))
      end
    end
  end
end
