# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Currencylayer::HistoricalCurrency do
  let(:historical) { described_class.new(date, currencies) }
  let(:date) { response[:date] }
  let(:currencies) { ['EUR'] }

  let(:client) do
    instance_double(Currencylayer::Client,
                    fetch_history: OpenStruct.new(response))
  end
  let(:response) { FactoryBot.attributes_for(:currencylayer_response) }

  before do
    allow(historical).to receive(:client).and_return(client)
  end

  describe '#import!' do
    subject(:import) { historical.import! }

    it 'forwards params to client' do
      expect(client)
        .to receive(:fetch_history).with(date: date, currencies: currencies)

      import
    end

    it 'upserts currency' do
      expect(Currency).to receive(:upsert_for!)
        .with(base: response[:source], foreign_rates: Array, published_at: Date)

      import
    end
  end
end
