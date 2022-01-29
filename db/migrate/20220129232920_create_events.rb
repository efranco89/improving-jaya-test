class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :action
      t.string :number
      t.bigint :issue_id

      t.timestamps
    end
  end
end
