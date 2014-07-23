require 'rails_helper'

describe DogsController do
  it 'displays all dogs' do
    get :index, format: :json
    expect(response).to be_success
  end
end