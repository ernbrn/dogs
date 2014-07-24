FactoryGirl.define do
  factory :dog do
    sequence(:name) { |n| "Name #{n}" }
    breed "Breed"
    summary "Summary"
    bio "Bio"
    image "image"
  end
end