require "rails_helper"

RSpec.describe Api::V1::NPCsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/npcs").to route_to("api/v1/npcs#index")
    end

    it "routes to #random" do
      expect(get: "/v1/npcs/random").to route_to("api/v1/npcs#random")
    end

    it "routes to #show" do
      expect(get: "/v1/npcs/1").to route_to("api/v1/npcs#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/v1/npcs").to route_to("api/v1/npcs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/npcs/1").to route_to("api/v1/npcs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/npcs/1").to route_to("api/v1/npcs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/npcs/1").to route_to("api/v1/npcs#destroy", id: "1")
    end
  end
end
