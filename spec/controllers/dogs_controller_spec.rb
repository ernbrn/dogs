require 'rails_helper'

describe DogsController do
  it 'Get :index' do
    dogs = create_list(:dog, 2)
    get :index, format: :json
    expect(response).to be_success
    data = JSON.parse(response.body)
    expect(data.size).to eq 2
    expect(data.first).to have_key('name')
    expect(data.first["name"]).to eq dogs.first.name
  end

  it 'GET :show' do
    dog = create(:dog)
    get :show, id: dog.id, format: :json
    data = JSON.parse(response.body)
    expect(data).to have_key('name')
    expect(data["name"]).to eq dog.name
  end

  describe 'POST :create' do
    before { @dog_attributes = attributes_for(:dog)}
    it 'succeeds when all attributes are set' do
      post :create, dog: @dog_attributes, format: :json
      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)
      expect(data).to have_key('name')
      expect(data["name"]).to eq @dog_attributes[:name]
    end

    it 'POST :create with Error' do
      @dog_attributes[:name] = nil
      post :create, dog: @dog_attributes, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH :update" do
    before {@dog = create(:dog)}
    it 'succeeds when data is changed' do
      patch :update, id: @dog.id, dog:{name: 'Henry'}, format: :json
      expect(response).to have_http_status(:no_content)
      expect(Dog.find(@dog.id).name).to eq 'Henry'
    end

    it 'fails when a required field is missing' do
      dog_name = @dog.name
      patch :update, id: @dog.id, dog:{name: nil}, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Dog.find(@dog.id).name).to eq dog_name
    end
  end

  it 'DELETE :destroy' do
    dog = create(:dog)
    delete :destroy, id: dog.id, format: :json
    expect(response).to have_http_status(:no_content)
    expect{Dog.find(dog.id)}.to raise_error ActiveRecord::RecordNotFound

  end
end