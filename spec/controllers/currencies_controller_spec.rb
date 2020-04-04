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
end
