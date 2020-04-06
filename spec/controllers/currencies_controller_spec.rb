# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CurrenciesController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'fetches most recent currency' do
      expect(Currency).to receive(:order)
        .with(published_at: :asc).and_call_original

      get :index
    end
  end

  describe 'GET #show' do
    let(:currency) { FactoryBot.create(:currency) }

    it "returns http success" do
      get :show, params: { id: currency.id }
      expect(response).to have_http_status(:success)
    end

    it 'sets currency based on id' do
      expect(Currency)
        .to receive(:find).with(currency.id.to_s).and_call_original

      get :show, params: { id: currency.id }
    end
  end

  describe 'GET #exchange' do
    let(:currency) { FactoryBot.create(:currency) }
    let(:exchange_params) do
      {
        id: currency.id,
        currency: { base: base, value: value, foreign: foreign }
      }
    end
    let(:base) { currency.base }
    let(:value) { 1.0 }
    let(:foreign) { currency.foreign_rates.sample['currency'] }

    let(:currency_exchanger) do
      instance_double(CurrencyExchanger, foreign_rate_for: 1)
    end

    before do
      allow(CurrencyExchanger).to receive(:new).and_return(currency_exchanger)
    end

    it "returns http success" do
      get :exchange, xhr: true, params: exchange_params

      expect(response).to have_http_status(:success)
    end

    it 'responds with javascript media type' do
      get :exchange, xhr: true, params: exchange_params

      expect(response.media_type).to eq('text/javascript')
    end

    it 'initializes service class with source and target_rates' do
      expect(CurrencyExchanger).to receive(:new)
        .with(base, currency.foreign_rates)
        .and_call_original

      get :exchange, xhr: true, params: exchange_params
    end

    it 'initialized service class returns foreign rate' do
      expect(currency_exchanger).to receive(:foreign_rate_for).with(foreign)

      get :exchange, xhr: true, params: exchange_params
    end
  end
end
