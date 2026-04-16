class CreateExpenses < ActiveRecord::Migration[8.1]
  def change
    create_table :expenses do |t|
      t.string :title
      t.decimal :amount
      t.integer :category
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
