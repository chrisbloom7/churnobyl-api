# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/v1/collections', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # NPC. As you add validations to NPC, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip('Add a hash of valid attributes for your model')
  }

  let(:invalid_attributes) {
    skip('Add a hash of attributes invalid for your model')
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CollectionsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe 'GET /v1/index' do
    xit 'returns http success' do
      get '/v1/collections', headers: valid_headers, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /v1/show' do
    xit 'returns http success' do
      get '/v1/collections/1', headers: valid_headers, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /v1/generate' do
    xit 'returns http success' do
      get '/v1/collections/1/generate', headers: valid_headers, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /v1/create' do
    xit 'returns http success' do
      post '/v1/collections', headers: valid_headers, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /v1/update' do
    xit 'returns http success' do
      put '/v1/collections/update', headers: valid_headers, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /v1/destroy' do
    xit 'returns http success' do
      get '/v1/collections/destroy', headers: valid_headers, as: :json
      expect(response).to have_http_status(:success)
    end
  end
end
