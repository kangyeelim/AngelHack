class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :strategy_id
      t.integer :indicator_id

      t.timestamps
    end
  end
end
