require "rails_helper"

RSpec.describe EmbeddedContentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/embedded_contents").to route_to("embedded_contents#index")
    end

    it "routes to #new" do
      expect(get: "/embedded_contents/new").to route_to("embedded_contents#new")
    end

    it "routes to #show" do
      expect(get: "/embedded_contents/1").to route_to("embedded_contents#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/embedded_contents/1/edit").to route_to("embedded_contents#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/embedded_contents").to route_to("embedded_contents#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/embedded_contents/1").to route_to("embedded_contents#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/embedded_contents/1").to route_to("embedded_contents#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/embedded_contents/1").to route_to("embedded_contents#destroy", id: "1")
    end
  end
end
