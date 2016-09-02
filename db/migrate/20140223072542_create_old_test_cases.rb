class CreateOldTestCases < ActiveRecord::Migration
  def change
    create_table :old_test_cases do |t|
      t.integer :test_plan_id
      t.string :name
      t.string :case_id
      t.string :version
      t.string :priority
      t.string :automated_status
      t.integer :test_link_id

      t.timestamps
    end
  end
end
