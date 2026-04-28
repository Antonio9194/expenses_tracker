class CreateMonthlySnapshots < ActiveRecord::Migration[8.1]
  def change
    create_table :monthly_snapshots do |t|
      t.references :user, null: false, foreign_key: true
      t.date :month
      t.decimal :budget_amount
      t.decimal :savings

      t.timestamps
    end
  end
end
