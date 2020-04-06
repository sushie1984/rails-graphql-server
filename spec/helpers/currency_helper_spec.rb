# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CurrencyHelper, type: :helper do
  describe '#available_options' do
    subject(:available_options) { helper.available_options(currency) }
    let(:currency) do
      FactoryBot.create(:currency,
                        base: base,
                        foreign_rates: [{ 'currency': foreign }])
    end
    let(:base) { 'FOO' }
    let(:foreign) { 'BAR' }

    it { is_expected.to eq([['FOO', 'FOO'], ['BAR', 'BAR']]) }

    context 'when base and foreign are the same' do
      let(:base) { 'FOO' }
      let(:foreign) { base }

      it { is_expected.to eq([['FOO', 'FOO']]) }
    end
  end
end
