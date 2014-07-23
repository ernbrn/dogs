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
    get :show, dog_id: 1, format: :json
    data = JSON.parse(response.body)
    expect(data).to have_key('name')
    expect(data["name"]).to eq dog.name

  end
  it 'POST :create'
  it 'PATCH :upsdate'
  it 'DELETE :destroy'
end