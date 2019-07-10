class CreateStrategies < ActiveRecord::Migration[5.1]
  def change
    create_table :strategies do |t|
      t.string :strategy_name
      t.string :explanation
      t.string :indicators

      t.timestamps
    end
  end
end
