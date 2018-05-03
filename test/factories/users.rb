FactoryGirl.define do
  factory :user do
    first_name 'betty'
    email {"#{first_name}maker@gmail.com"}
    password "12345678"
    password_confirmation "12345678"

  end
end
