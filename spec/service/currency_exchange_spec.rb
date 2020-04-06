# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CurrencyExchanger do
  let(:exchanger) { described_class.new(base_currency, foreign_rates) }
  let(:foreign_rates) { [euro_to_dollar, swiss_franc_to_dollar] }
  let(:euro_to_dollar) { { 'currency' => 'EUR', 'rate' => 0.5 } }
  let(:swiss_franc_to_dollar) { { 'currency' => 'CHF', 'rate' => 0.8 } }

  describe '#foreign_rate_for' do
    subject(:foreign_rate_for) { exchanger.foreign_rate_for(foreign_currency) }
    let(:base_currency) { 'USD' }
    let(:foreign_currency) { 'EUR' }
    let(:dollar_to_euro_rate) { euro_to_dollar['rate'] }

    it { is_expected.to eq(dollar_to_euro_rate) }

    context 'when swapping base_currency and foreign_currency currency' do
      let(:base_currency) { 'EUR' }
      let(:foreign_currency) { 'USD' }
      let(:euro_to_dollar_rate) { 2.0 }

      it { is_expected.to eq(euro_to_dollar_rate) }
    end

    context 'with base and foreign_currency being part of foreign_rates' do
      let(:base_currency) { 'CHF' }
      let(:foreign_currency) { 'EUR' }
      let(:swiss_franc_to_euro_rate) { 0.625 }

      it { is_expected.to eq(swiss_franc_to_euro_rate) }
    end

    context 'with base and foreign_currency being the same' do
      let(:base_currency) { 'USD' }
      let(:foreign_currency) { base_currency }

      it { is_expected.to eq(1.0) }
    end

    context 'with undefined foreign_currency' do
      let(:foreign_currency) { 'FOO' }

      it 'raises an error' do
        expect { foreign_rate_for }.to raise_error(UnknownCurrency)
      end
    end
  end
end
