FactoryBot.define do
  factory :event do
    action { "action" }
    number { "number" }
    issue_id { rand(1..321321321321) }
  end
end
