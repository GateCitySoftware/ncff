require "rails_helper"

RSpec.describe StageSchedulesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/stage_schedules").to route_to("stage_schedules#index")
    end

    it "routes to #new" do
      expect(get: "/stage_schedules/new").to route_to("stage_schedules#new")
    end

    it "routes to #show" do
      expect(get: "/stage_schedules/1").to route_to("stage_schedules#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/stage_schedules/1/edit").to route_to("stage_schedules#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/stage_schedules").to route_to("stage_schedules#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/stage_schedules/1").to route_to("stage_schedules#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/stage_schedules/1").to route_to("stage_schedules#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/stage_schedules/1").to route_to("stage_schedules#destroy", id: "1")
    end
  end
end
