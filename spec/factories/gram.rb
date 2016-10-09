FactoryGirl.define do
  factory :gram do
    message "hello"
    association :user
  end
end
