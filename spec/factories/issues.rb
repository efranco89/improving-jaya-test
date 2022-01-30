FactoryBot.define do
  factory :issue do
    github_issue_id { rand(12321564..72321564).to_s }
    sequence(:tittle, 1) { |n| "This is the issue's tittle #{n}"}

    after(:create) do | issue, evaluator |
      actions = %w[create update open close push pull]
      rand(5..20).times do
        create(
          :event,
          action: actions.sample,
          number: issue.github_issue_id,
          issue_id: issue.id
        )
      end
    end
  end
end
