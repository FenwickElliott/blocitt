FactoryGirl.define do
    factory :vote do
        value Random.new.rand(-1..1)
        post
        user
    end
end
