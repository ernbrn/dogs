require 'rails_helper'

describe DogsController do
  it 'Get :index' do
    dogs = create_list(:dog, 2)
    get :index, format: :json
    expect(response).to be_success
    data = JSON.parse(response.body)
    expect(data.size).to eq 2
    expect(data.first).to have_key('image_url')
    expect(data.first).to have_key('name')
    expect(data.first["name"]).to eq dogs.first.name
  end

  describe "GET :show" do
    before { @dog = create(:dog) }
    it 'can show a valid dog' do
      get :show, id: @dog.id, format: :json
      data = JSON.parse(response.body)
      expect(data).to have_key('name')
      expect(data["name"]).to eq @dog.name
    end

    it 'cannot show a dog that does not exist' do
      expect{ get(:show, id: 1, format: :json) }.to raise_error ActiveRecord::RecordNotFound
    end

    it "cannot render in anything but json" do
      expect{ get(:show, id: @dog.id, format: :js) }.to raise_error ActionController::UnknownFormat
      expect{ get(:show, id: @dog.id, format: :html) }.to raise_error ActionController::UnknownFormat
      expect{ get(:show, id: @dog.id, format: :xml) }.to raise_error ActionController::UnknownFormat
      expect{ get(:show, id: @dog.id, format: :not_valid) }.to raise_error ActionController::UnknownFormat
    end

    it "serve image_url instead of image_uid" do
      url =  @dog.image.url
      expect(url).to_not be_nil
    end

  end

  describe 'POST :create' do
    before { @dog_attributes = attributes_for(:dog) }
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

    it 'cannot create with the wrong format' do
      expect{ post(:create, dog: @dog_attributes, format: :html)}.to raise_error ActionController::UnknownFormat
      expect{ post(:create, dog: @dog_attributes, format: :js)}.to raise_error ActionController::UnknownFormat
      expect{ post(:create, dog: @dog_attributes, format: :xml)}.to raise_error ActionController::UnknownFormat
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
      dog_id = @dog.id
      patch :update, id: dog_id, dog:{name: nil}, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Dog.find(dog_id).name).to eq dog_name
    end

  end

  describe 'DELETE :destroy' do
    it 'can delete an existing record' do
      dog = create(:dog)
      delete :destroy, id: dog.id, format: :json
      expect(response).to have_http_status(:no_content)
      expect{Dog.find(dog.id)}.to raise_error ActiveRecord::RecordNotFound
    end

    it 'cannot delete a nonexistent record' do
      expect{Dog.destroy(1)}.to raise_error ActiveRecord::RecordNotFound
    end
  end
end

