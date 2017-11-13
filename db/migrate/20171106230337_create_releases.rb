class CreateReleases < ActiveRecord::Migration[5.1]
  def change
    create_table :releases do |t|
      t.integer :year
      t.float :quantity
      t.string :units

      t.timestamps
    end
  end
end
