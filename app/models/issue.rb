class Issue < ApplicationRecord
  self.primary_key = 'github_issue_id'
  has_many :events, primary_key: 'github_issue_id', foreign_key: 'number'
end
