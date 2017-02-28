require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

    let (:my_q) do
        Question.create(
        id: 1,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        resolved: false
        )
    end

      describe "GET #index" do
        it "returns http success" do
          get :index
          expect(response).to have_http_status(:success)
        end

        it 'assigns my_q to @question' do
            get :index
            expect(assigns(:questions)).to eq([my_q])
        end
      end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_q.id}
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
        get :show, {id: my_q.id}
        expect(response).to render_template :show
    end

    it 'assigns my_q to @question' do
        get :show, {id: my_q.id}
        expect(assigns(:question)).to eq(my_q)
    end
  end

  describe 'GET create' do
      it 'increases the number of Questions by 1' do
          expect{ post :create, {question: {title: 'title', body: 'body', resolved: false}}}.to change(Question, :count).by(1)
      end

      it 'assigns the new question to @question' do
          post :create, {question: my_q.attributes}
          expect(assigns(:question)).to eq Question.last
      end

      it 'redirects to the new question' do
          post :create, {question: my_q.attributes}
          expect(response).to redirect_to Question.last
      end
  end

  describe 'GET edit' do
      it 'returns http success' do
          get :edit, {id: my_q.id}
          expect(response).to have_http_status(:success)
      end

      it 'renders the #edit view' do
          get :edit, {id: my_q.id}
          expect(responce).to render_template :edit
      end
  end


  describe 'PUT update' do
      it 'updates question with expected attributes' do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, id: my_q.id, question: {title: new_title, body: new_body, resolved: false}

        updated_question = assigns(:question)
        expect(updated_question.id).to eq my_q.id
        expect(updated_question.title).to eq new_title
        expect(updated_question).to eq new_body
      end

      it 'redirects to the updated question' do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, id: my_q.id, question: {title: new_title, body: new_body, resolved: true}
        expect(response).to redirect_to my_q
      end
  end

  describe 'DELETE destroy' do
      it 'deletes the question' do
          delete :destroy, {id: my_q.id}
          count = Question.where({id: my_q.id}).size
          expect(count).to eq 0
      end

      it ' redirects to questions index' do
          delete :destroy, {id: my_question.id}
          expect(response).to redirect_to questions_path
      end
  end 
end
