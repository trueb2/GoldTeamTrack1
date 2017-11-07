# Seed using the basic_data_files.csv from Kaggle

count = 0
open('basic_data_files.csv') do |csv|
  csv.each_line do |row|
    record = row.split(',')
    Company.find_or_create_by!(name: record[107])
    count += 1
    puts("Processing row #{count}") if count % 100 == 0
  end
end
