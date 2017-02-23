require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
    describe "GET index" do
        it "renders the blank index page" do
            get :index
            expect(response).to render_template("index")
        end
    end
    describe "GET about" do
        it "renders the about page" do
            get :about
            expect(response).to render_template("about")
        end
    end
    describe "GET contact" do
        it 'renders the contact page' do
            get :contact
            expect(response).to render_template('contact')
        end
    end
end
