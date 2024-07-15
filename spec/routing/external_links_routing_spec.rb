require "rails_helper"

RSpec.describe ExternalLinksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/external_links").to route_to("external_links#index")
    end

    it "routes to #new" do
      expect(get: "/external_links/new").to route_to("external_links#new")
    end

    it "routes to #show" do
      expect(get: "/external_links/1").to route_to("external_links#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/external_links/1/edit").to route_to("external_links#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/external_links").to route_to("external_links#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/external_links/1").to route_to("external_links#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/external_links/1").to route_to("external_links#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/external_links/1").to route_to("external_links#destroy", id: "1")
    end
  end
end
