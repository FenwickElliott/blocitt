require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    # let(:my_user) { User.create!(name: "Charles", email: "charles@FenwickElliott.io", password: "helloworld") }
    let(:my_user) { User.create!(name: "Blochead", email: "blochead@bloc.io", password: "password") }

    describe "GET new" do
        it "1: returns http success" do
            get :new
            expect(response).to have_http_status(:success)
        end
    end

    describe "POST sessions" do
        it "2: returns http success" do
            post :create, session: {email: my_user.email}
            expect(response).to have_http_status(:success)
        end
        it "3: initializes a session" do
            post :create, session: {email: my_user.email, password: my_user.password}
            expect(session[:user_id]).to eq my_user.id
        end
        it "4: does not add a user id to session due to missing password" do
            post :create, session: {email: my_user.email}
            expect(session[:user_id]).to be_nil
        end
        it "5: flashes #error with bad email address" do
            post :create, session: {email: "does not exist"}
            expect(flash.now[:alert]).to be_present
        end
        it "6: renders #new with bad email address" do
            post :create, session: {email: "does not exist"}
            expect(response).to render_template :new
        end
        it "7: redirects to the root view" do
            post :create, session: {email: my_user.email, password: my_user.password}
            expect(response).to redirect_to(root_path)
        end
    end

    describe "DELETE sessions/id" do
        it "8: render the #welcome view" do
            delete :destroy, id: my_user.id
            expect(response).to redirect_to root_path
        end

        it "9: deletes the user's session" do
            delete :destroy, id: my_user.id
            expect(assigns(:session)).to be_nil
        end

        it "10: flashes #notice" do
            delete :destroy, id: my_user.id
            expect(flash[:notice]).to be_present
        end
    end
end
