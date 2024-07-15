require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/external_links", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # ExternalLink. As you add validations to ExternalLink, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      ExternalLink.create! valid_attributes
      get external_links_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      external_link = ExternalLink.create! valid_attributes
      get external_link_url(external_link)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_external_link_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      external_link = ExternalLink.create! valid_attributes
      get edit_external_link_url(external_link)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ExternalLink" do
        expect {
          post external_links_url, params: { external_link: valid_attributes }
        }.to change(ExternalLink, :count).by(1)
      end

      it "redirects to the created external_link" do
        post external_links_url, params: { external_link: valid_attributes }
        expect(response).to redirect_to(external_link_url(ExternalLink.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ExternalLink" do
        expect {
          post external_links_url, params: { external_link: invalid_attributes }
        }.to change(ExternalLink, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post external_links_url, params: { external_link: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested external_link" do
        external_link = ExternalLink.create! valid_attributes
        patch external_link_url(external_link), params: { external_link: new_attributes }
        external_link.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the external_link" do
        external_link = ExternalLink.create! valid_attributes
        patch external_link_url(external_link), params: { external_link: new_attributes }
        external_link.reload
        expect(response).to redirect_to(external_link_url(external_link))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        external_link = ExternalLink.create! valid_attributes
        patch external_link_url(external_link), params: { external_link: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested external_link" do
      external_link = ExternalLink.create! valid_attributes
      expect {
        delete external_link_url(external_link)
      }.to change(ExternalLink, :count).by(-1)
    end

    it "redirects to the external_links list" do
      external_link = ExternalLink.create! valid_attributes
      delete external_link_url(external_link)
      expect(response).to redirect_to(external_links_url)
    end
  end
end
