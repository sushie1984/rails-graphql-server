require 'rails_helper'

RSpec.describe Currencylayer::Client do
  let(:client) { described_class.new(base_uri, access_key, source) }
  let(:base_uri) { 'http://foo.bar' }
  let(:access_key) { 'secrect_access_key' }
  let(:source) { 'EUR' }

  let(:response) do
    instance_double(HTTParty::Response, parsed_response: parsed_response)
  end
  let(:parsed_response) { FactoryBot.attributes_for(:currencylayer_response) }

  before do
    allow(Currencylayer::Client).to receive(:get).and_return(response)
  end

  describe '#fetch_history' do
    subject(:fetch_history) do
      client.fetch_history(date: date, currencies: currencies)
    end
    let(:date) { Date.today }
    let(:currencies) { ['USD', 'CHF'] }

    it 'responds with OpenStruct' do
      expect(fetch_history).to be_a(OpenStruct)
    end

    it 'wraps parsed_response within the OpenStruct' do
      expect(OpenStruct).to receive(:new).with(parsed_response)

      fetch_history
    end

    context 'with invalid date format' do
      let(:date) { 'Foobar' }

      it 'raises an ArgumentError' do
        expect { fetch_history }.to raise_error(ArgumentError)
      end
    end

    context 'with invalid currencies format' do
      let(:currencies) { 'Foobar' }

      it 'raises a NoMethodError' do
        expect { fetch_history }.to raise_error(NoMethodError)
      end
    end

    context 'when currencylayer query did not succeed' do
      let(:parsed_response) do
        FactoryBot.attributes_for(:currencylayer_response, :unsuccessfull)
      end

      it 'raises an UnsuccessfullQueryError' do
        expect { fetch_history }
          .to raise_error(Currencylayer::UnsuccessfullQueryError)
      end
    end
  end
end
