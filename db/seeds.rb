# Seed using the basic_data_files.csv from Kaggle
def cast_bool(i)
    return true if i == "YES"
    return false if i == "NO"
    begin
        return false if Integer(i) == 0
    rescue
       return true 
    end
    true
end

count = 0
lookup = {}
open('basic_data_files.csv') do |csv|
  csv.each_line do |row|

    r = row.split(',')

    if count == 0
        r.each_with_index do |field, idx|
           lookup[field] = idx 
        end
        count += 1
        next
    end

    company_name = r[lookup["PARENT_COMPANY_NAME"]]
    if !company_name.empty?
        company = Company.find_or_create_by!(name: company_name)
    else
	next
    end

    begin
    chemical = Chemical.find_or_create_by!(name: r[lookup["CHEMICAL"]])
    chemical.update({ 
        compound_id: r[lookup["CAS_#/COMPOUND_ID"]],
        is_metal: cast_bool(r[lookup["METAL"]]),
        metal_category: r[lookup["METAL_CATEGORY"]],
        clear_air_act_chemical: cast_bool(r[lookup["CLEAR_AIR_ACT_CHEMICAL"]]),
    })

    facility = Facility.find_or_create_by!(name: r[lookup["FACILITY_NAME"]], company: company)
    facility.update({
        company: company,
        address: r[lookup["STREET_ADDRESS"]],
        city: r[lookup["CITY"]],
        country: "USA",
        state: r[lookup["ST"]],
        zip: r[lookup["ZIP"]],
        latitude: r[lookup["LATITUDE"]],
        longitude: r[lookup["LONGITUDE"]],
        federally_owned: cast_bool(r[lookup["FEDERAL_FACILITY"]]),
    })

    Release.create({
        chemical: chemical,
        facility: facility,
        date: r[lookup["YEAR"]],
        units: r[lookup["UNIT_OF_MEASURE"]],
    })

    count += 1
    puts("Processing row #{count}") if count % 100 == 0
    end
  end
end
