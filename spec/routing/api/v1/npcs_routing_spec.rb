# frozen_string_literal: true
require "rails_helper"

RSpec.describe API::V1::NPCsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      skip("Deprecated")
      expect(get: "/v1/npcs").to route_to("api/v1/npcs#index", format: :json)
    end

    it "routes to #random" do
      skip("Deprecated")
      expect(get: "/v1/npcs/random").to route_to("api/v1/npcs#random", format: :json)
    end

    it "routes to #show" do
      skip("Deprecated")
      expect(get: "/v1/npcs/1").to route_to("api/v1/npcs#show", id: "1", format: :json)
    end

    it "routes to #create" do
      skip("Deprecated")
      expect(post: "/v1/npcs").to route_to("api/v1/npcs#create", format: :json)
    end

    it "routes to #update via PUT" do
      skip("Deprecated")
      expect(put: "/v1/npcs/1").to route_to("api/v1/npcs#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      skip("Deprecated")
      expect(patch: "/v1/npcs/1").to route_to("api/v1/npcs#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      skip("Deprecated")
      expect(delete: "/v1/npcs/1").to route_to("api/v1/npcs#destroy", id: "1", format: :json)
    end
  end
end
