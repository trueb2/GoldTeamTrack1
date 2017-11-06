class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.string :state
      t.integer :zip
      t.float :latitude
      t.float :longitude
      t.boolean :federally_owned

      t.timestamps
    end
  end
end
