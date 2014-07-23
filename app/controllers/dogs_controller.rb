class DogsController < ApplicationController
respond_to :json

  def index
    @dogs = Dog.all
    respond_with @dogs
  end
end
