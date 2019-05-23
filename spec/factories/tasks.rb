FactoryBot.define do
    factory :task do
        name {'ただいまマイクのテスト中'}
        body {'内容は無いよう'}
        user
    end
end
