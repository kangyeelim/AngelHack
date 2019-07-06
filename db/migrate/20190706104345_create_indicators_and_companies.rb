class CreateIndicatorsAndCompanies < ActiveRecord::Migration[5.1]
  def change

    # INDICATORS ==================================================

    create_table :indicators do |t|
      t.string :type
      t.float :value
      t.datetime :last_updated
      t.integer :company_id, foreign_key: true

      t.timestamps
    end

    # COMPANIES ===================================================

    create_table :companies do |t|
      t.string :name
      t.string :ticker

      t.timestamps
    end

    # INDICATOR TYPES =============================================

    create_table :indicator_types do |t|
      t.string :type
      t.float :pass_value
      t.text :description

      t.timestamps
    end
  end
end