require 'rails_helper'

RSpec.describe GramsController, type: :controller do

  describe "grams#show action" do

    it "should successfully show the page if the gram is found" do

      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user
      gram = Gram.create(
        message: "hello",
        user_id: user.id
      )

      get :show, id: gram.id
      expect(response).to have_http_status(:success)

    end

    it "should return a 404 error if the gram is not found" do
      get :show, id: 'TACOCAT'
      expect(response).to have_http_status(:not_found)
    end

  end


  describe "grams#edit action" do

    it "should successfully show the edit page if the gram is found" do

      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user
      gram = Gram.create(
        message: "hello",
        user_id: user.id
      )

      get :edit, id: gram.id
      expect(response).to have_http_status(:success)

    end

    it "should return a 404 error if the gram is not found" do
      get :edit, id: 'SWAG'
      expect(response).to have_http_status(:not_found)
    end

  end

  describe "grams#update action" do

    it "should allow users to successfully update grams" do

      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user
      p = Gram.create(
        message: "initial value",
        user_id: user.id
      )

      patch :update, id: p.id, gram: { message: 'Changed' }
      expect(response).to redirect_to root_path

      p.reload
      expect(p.message).to eq "Changed"

    end

    it "should return a 404 error if the gram is not found" do
      patch :update, id: "YOLOSWAG", gram: {message: "changed value"}
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessabile_entity" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      p = Gram.create(
        message: "Initial Value",
        user_id: user.id
      )

      patch :update, id: p.id, gram: { message: '' }
      expect(response).to have_http_status(:unprocessable_entity)

      p.reload
      expect(p.message).to eq "Initial Value"
    end

  end

  describe "grams#index action " do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do

    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#create action" do

    it "should require users to be logged in" do
      post :create, gram: { message: "Hello" }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new gram in our database" do

      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user

      post :create, gram: {message: "Hello!"}
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      expect(gram.user).to eq(user)
    end
  end

  it "should properly deal with validaiton errors" do

    user = User.create(
      email:                 'fakeuser@gmail.com',
      password:              'secretPassword',
      password_confirmation: 'secretPassword'
    )
    sign_in user


    post :create, gram: {message: '' }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(Gram.count).to eq 0
  end

end
