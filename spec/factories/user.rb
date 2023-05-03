FactoryBot.define do
    factory :user do
        trait :with_basic_details do
            name { 'TEST' }
            username { 'test' }
            email { 'test@test.com' }
        end
    end
end