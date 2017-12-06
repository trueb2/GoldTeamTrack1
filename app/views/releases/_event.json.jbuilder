json.extract! release, :id, :year, :quantity, :units
json.facility do
  json.extract! release.facility, :id, :name, :address, :city, :state, :zip, :latitude, :longitude, :federally_owned
  json.company release.facility.company.try(:name)
end
json.chemical do
  json.extract! release.chemical, :name, :clear_air_act_chemical, :is_metal
end
