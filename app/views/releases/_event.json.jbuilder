json.set! :id, release["id"]
json.set! :year, release["year"]
json.set! :quantity, release["quantity"]
json.set! :units, release["units"]
json.set! :facility do
  json.set! :name, release["name"]
  json.set! :address, release["address"]
  json.set! :city, release["city"]
  json.set! :state, release["state"]
  json.set! :zip, release["zip"]
  json.set! :latitude, release["latitude"]
  json.set! :longitude, release["longitude"]
  json.set! :federally_owned, release["federally_owned"]
  json.set! :company, release["company_name"]
end
json.set! :chemical do
  json.set! :name, release["name"]
  json.set! :clear_air_act_chemical, release["clear_air_act_chemical"]
  json.set! :is_metal, release["is_metal"]
end
# json.extract! release, :id, :year, :quantity, :units
# json.facility do
#   json.extract! release.facility, :name, :address, :city, :state, :zip, :latitude, :longitude, :federally_owned
#   json.company release.facility.company.try(:name)
# end
# json.chemical do
#   json.extract! release.chemical, :name, :clear_air_act_chemical, :is_metal
# end
