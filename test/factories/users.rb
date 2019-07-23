FactoryBot.define do
  factory :user do
    first_name { "A" }
    last_name { "User" }
    email { "user@example.com" }
    admin { false }
    password { "secret123" }

    trait :admin do
      first_name { "An" }
      last_name { "Admin" }
      admin { true }
      email { "admin@example.com" }
    end
  end
end
