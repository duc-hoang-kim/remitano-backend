require 'rails_helper'

describe Auth::SessionsController, type: [:controller, :devise_controller] do
  let(:password) { "secure_password" }
  let!(:user) { create(:user, password: password, password_confirmation: password) }

  describe "GET #show" do
    context "when user is authenticated" do
      before do
        sign_in user
        get :show
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the current user's data" do
        expect(response.body).to eq({ data: { user: user.reload } }.to_json)
      end
    end

    context "when user is not authenticated" do
      before do
        get :show
      end

      it "returns http unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns an error message" do
        expect(response.body).to eq({ error: "You need to sign in or sign up before continuing." }.to_json)
      end
    end
  end

  describe "POST #create" do
    context "when user is not logged in" do
      before do
        post :create, params: { user: { email: user.email, password: password } }
      end

      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it "logs in the user" do
        expect(session[:current_user_id]).to eq(user.id)
      end

      it "returns the current user's data" do
        expect(response.body).to eq({ data: { user: user.reload } }.to_json)
      end
    end

    context "when user is already logged in" do
      before do
        session[:current_user_id] = user.id
        sign_in user
        post :create, params: { user: { email: user.email, password: password } }
      end

      it "returns http forbidden" do
        expect(response).to have_http_status(:forbidden)
      end

      it "returns an error message" do
        expect(response.body).to eq({ error: "User have already logged in" }.to_json)
      end
    end

    context "when email or password is incorrect" do
      before do
        post :create, params: { user: { email: user.email, password: "incorrect_password" } }
      end

      it "returns http unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns an error message" do
        expect(response.body).to eq("Invalid Email or password.")
      end
    end
  end

   describe "DELETE #destroy" do
    context "when user is logged in" do
      before do
        sign_in user
        delete :destroy
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "logs out the user" do
        expect(session[:current_user_id]).to be_nil
      end

      it "returns a success message" do
        expect(response.body).to eq({ data: { success: true } }.to_json)
      end
    end

    context "when user is not logged in" do
      before do
        delete :destroy
      end

      it "returns http forbidden" do
        expect(response).to have_http_status(:forbidden)
      end

      it "returns an error message" do
        expect(response.body).to eq({ error: "User have already logged out."}.to_json)
      end
    end
  end
end
