class CreateIndicatorsAndCompanies < ActiveRecord::Migration[5.1]
  def change

    # INDICATORS ==================================================

    create_table :indicators do |t|
      t.string :category, foreign_key: true
      t.float :value
      t.datetime :last_updated
      t.integer :company_id, foreign_key: true
      t.text :description

      t.timestamps
    end

    # COMPANIES ===================================================

    create_table :companies do |t|
      t.string :name
      t.string :ticker

      t.timestamps
    end
  end
end