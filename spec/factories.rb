FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'password1' }
    name { 'Dentarthurdent' }
  end
end
