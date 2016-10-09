FactoryGirl.define do
  factory :gram do
    message "hello"
    picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.png'), 'image/png') }
    association :user
  end
end
