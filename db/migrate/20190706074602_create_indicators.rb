class CreateIndicators < ActiveRecord::Migration[5.1]
  def change
    create_table :indicators do |t|
      t.string :name
      t.text :explanation
      t.text :function

      t.timestamps
    end
  end
end
