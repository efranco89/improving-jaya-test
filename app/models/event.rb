class Event < ApplicationRecord
  self.primary_key = 'number'
  belongs_to :issue, primary_key: 'github_issue_id', foreign_key: 'number'
end
