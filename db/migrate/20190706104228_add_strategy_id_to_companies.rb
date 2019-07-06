class AddStrategyIdToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :strategy_id, :integer
  end
end
