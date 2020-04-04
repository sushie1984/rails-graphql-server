require "rails_helper"

RSpec.describe CurrencyHelper, type: :helper do
  describe '#available_options' do
    subject(:available_options) { helper.available_options(currency) }
    let(:currency) do
      FactoryBot.create(:currency,
                        source: source,
                        target_rates: [{ 'target': target}])
    end
    let(:source) { 'FOO' }
    let(:target) { 'BAR' }

    it { is_expected.to eq([['FOO', 'FOO'], ['BAR', 'BAR']]) }

    context 'when source and target are the same' do
      let(:source) { 'FOO' }
      let(:target) { source }

      it { is_expected.to eq([['FOO', 'FOO']]) }
    end
  end
end
