class AddReleaseAssocationWithFacilityAndChemical < ActiveRecord::Migration[5.1]
  def change
	add_reference :releases, :chemical, foreign_key: true
	add_reference :releases, :facility, foreign_key: true
  end
end
