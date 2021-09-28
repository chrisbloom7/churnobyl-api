# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::V1::CollectionsController', type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/collections').to route_to('api/v1/collections#index', format: :json)
    end

    it 'routes to #show' do
      expect(get: '/v1/collections/1').to route_to('api/v1/collections#show', id: '1', format: :json)
    end

    it 'routes to #generate' do
      expect(get: '/v1/collections/1/generate').to route_to('api/v1/collections#generate', id: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/v1/collections').to route_to('api/v1/collections#create', format: :json)
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/collections/1').to route_to('api/v1/collections#update', id: '1', format: :json)
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/collections/1').to route_to('api/v1/collections#update', id: '1', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/collections/1').to route_to('api/v1/collections#destroy', id: '1', format: :json)
    end
  end
end
