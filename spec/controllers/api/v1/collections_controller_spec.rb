# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::CollectionsController, type: :controller do
  describe 'GET #index' do
    xit 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    xit 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    xit 'returns http success' do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #create' do
    xit 'returns http success' do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #update' do
    xit 'returns http success' do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #destroy' do
    xit 'returns http success' do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end
end
