# json.array! @releases, partial: 'releases/tree', as: :release
json.array! @releases do |release|
  json.set! :company_name, release["company_name"]
  json.set! :facility_name, release["facility_name"]
  json.set! :release_year, release["release_year"]
end
