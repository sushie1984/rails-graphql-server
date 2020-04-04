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
end
