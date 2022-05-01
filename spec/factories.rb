FactoryBot.define do
  factory :user do
    email { 'user@example.com' }
    password { 'password_user_1' }
    name { 'User McUserface' }
  end

  factory :ingredient do
    name { 'Hard cheese' }
    slug { 'hard-cheese' }
    aka { 'N/A' }
    eg { 'Parmesan, Cheddar, etc' }
  end
end
