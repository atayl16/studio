# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name  { 'Doe' }
    type { nil }
    email { 'john.doe@test.com' }
    password { 'asdfghjk' }
    password_confirmation { 'asdfghjk' }
  end

  factory :AdminUser, class: User do
    first_name { 'Jane' }
    last_name  { 'Admin' }
    type { AdminUser }
    email { 'jane.doe@test.com' }
    password { 'asdfghjk' }
    password_confirmation { 'asdfghjk' }
  end
end
