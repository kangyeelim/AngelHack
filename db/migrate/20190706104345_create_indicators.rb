class CreateIndicators < ActiveRecord::Migration[5.1]
  def change
    create_table :indicators do |t|
      t.string :indicator_type
      t.float :value
      t.datetime :last_updated
      t.integer :company_id, foreign_key: true

      t.timestamps
    end
  end
end
