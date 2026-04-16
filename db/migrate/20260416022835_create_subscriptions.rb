class CreateSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.decimal :amount
      t.integer :billing_cycle
      t.date :start_date
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
