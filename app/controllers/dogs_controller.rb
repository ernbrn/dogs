class DogsController < ApplicationController
respond_to :json
before_action :find_dog, only: [:show, :update, :destroy]

  def index
    @dogs = Dog.all
    respond_with @dogs
  end

  def show
    respond_with @dog
  end


  def create
    @dog = Dog.new(dog_params)
    @dog.save
    respond_with @dog
  end

  def destroy
    @dog.destroy
    respond_with @cat
  end

  private

  def find_dog
    @dog = Dog.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit :breed, :name, :birthdate, :bio, :summary
  end
end
