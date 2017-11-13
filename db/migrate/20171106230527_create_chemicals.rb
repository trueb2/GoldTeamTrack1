class CreateChemicals < ActiveRecord::Migration[5.1]
  def change
    create_table :chemicals do |t|
      t.string :name
      t.integer :compound_id, limit: 8
      t.boolean :clear_air_act_chemical
      t.boolean :is_metal
      t.string :metal_category

      t.timestamps
    end
  end
end
