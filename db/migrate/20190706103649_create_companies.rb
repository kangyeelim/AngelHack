class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.decimal :score

      t.timestamps
    end
  end
end
