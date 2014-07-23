class Dog < ActiveRecord::Base
  dragonfly_accessor :image

  validates :name, :bio, :breed, :summary, presence: true

end
