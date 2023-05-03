FactoryBot.define do
    factory :loan do
        amount { 10000 }
        term { 10 }
        user
        state { :paid }
    end
end