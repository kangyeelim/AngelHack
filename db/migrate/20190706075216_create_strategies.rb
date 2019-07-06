class CreateStrategies < ActiveRecord::Migration[5.1]
  def change
    create_table :strategies do |t|
      t.string :name
      t.text :explanation

      t.timestamps
    end
  end
end
