class AddDefaultEnabledToBudgets < ActiveRecord::Migration[8.1]
  def change
    change_column_default :budgets, :enabled, from: nil, to: false
  end
end
