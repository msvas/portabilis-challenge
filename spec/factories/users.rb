FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }
    uid { email }
    provider { 'email' }
    role { User.roles['Regular'] }
    status { User.statuses['Active'] }

    trait :admin do
      role { User.roles['Admin'] }
    end

    trait :suspended do
      status { User.statuses['Suspended'] }
    end
  end
end
