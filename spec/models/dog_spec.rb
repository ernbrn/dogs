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

require 'rails_helper'

describe Dog do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:bio) }
  it { is_expected.to validate_presence_of(:breed) }
  it { is_expected.to validate_presence_of(:summary) }


end
