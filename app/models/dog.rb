# == Schema Information
#
# Table name: dogs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  image_uid  :string(255)
#  birthdate  :date
#  breed      :string(255)
#  summary    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  bio        :text
#

class Dog < ActiveRecord::Base
  dragonfly_accessor :image

  validates :name, :bio, :breed, :summary, presence: true


end
