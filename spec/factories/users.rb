FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    type { nil }
    email {"john.doe@test.com"}
    user_id {"1"}
  end

  factory :AdminUser, class: User do
    first_name { "Jane" }
    last_name  { "Admin" }
    type { AdminUser }
    email {"jane.doe@test.com"}
    user_id {"2"}
  end
end
