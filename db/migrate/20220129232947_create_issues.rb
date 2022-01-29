class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :github_issue_id
      t.string :tittle

      t.timestamps
    end
  end
end
