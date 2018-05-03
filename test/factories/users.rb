FactoryGirl.define do
  factory :user do
    first_name 'betty'
    last_name 'Lastname'
    email {"#{first_name}maker@gmail.com"}
    password "12345678"
    password_confirmation "12345678"
  end
end
