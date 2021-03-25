require 'faker'
require 'csv'


Faker::Config.locale = 'en-US'


User.create!({
    "email"=>"nicolas.genest@codeboxx.biz", 
    "password"=> "newdog1", 
    "supervisor_role"=> true
    })
User.create!({
    "email"=>"nadya.fortier@codeboxx.biz", 
    "password"=> "newcat1", 
    "supervisor_role"=> true
    })
User.create!({
    "email"=>"martin.chantal@codeboxx.biz", 
    "password"=> "newfish1", 
    "supervisor_role"=> true
    })
User.create!({
    "email"=>"mathieu.houde@codeboxx.biz", 
    "password"=> "newlizard1", 
    "supervisor_role"=> true
    })
User.create!({
    "email"=>"david.boutin@codeboxx.biz", 
    "password"=> "newpig1", 
    "supervisor_role"=> true
    })
User.create!({
    "email"=>"mathieu.lortie@codeboxx.biz", 
    "password"=> "newcow1", 
    "supervisor_role"=> true
    })
User.create!({
    "email"=>"thomas.carrier@codeboxx.biz", 
    "password"=> "newpet1", 
    "supervisor_role"=> true
    })

Employee.create!({
    "first_name"=> "Nicolas",
    "last_name"=> "Genest",
    "title"=> "CEO", 
    "user_id"=>1
    })
Employee.create!({
    "first_name"=> "Nadya", 
    "last_name"=> "Fortier", 
    "title"=> "Director",
    "user_id"=> 2
    })
Employee.create!({
    "first_name"=> "Martin", 
    "last_name"=> "Chantal", 
    "title"=> "Director Assistant",
    "user_id"=>3
    })
Employee.create!({
    "first_name"=> "Mathieu", 
    "last_name"=> "Houde", 
    "title"=> "Captain", 
    "user_id"=>4
    })
Employee.create!({
    "first_name"=> "David", 
    "last_name"=> "Boutin", 
    "title"=> "Engineer", 
    "user_id"=>5
    })
Employee.create!({
    "first_name"=> "Mathieu", 
    "last_name"=> "Lortie", 
    "title"=> "Engineer" ,
    "user_id"=>6
    })
Employee.create!({"first_name"=> "Thomas", 
    "last_name"=> "Carrier", 
    "title"=> "Engineer",
    "user_id"=>7
    })

csv_addresses = File.read(Rails.root.join('lib', 'seeds', 'addresses.csv'))
csv = CSV.parse(csv_addresses, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
    t = Address.new

    t.type_of_address = row['type_of_address']
    t.status = row['status']
    t.entity = row ['entity']
    t.number_and_street = row ['number_and_street']
    t.suite_or_apartment = row ['suite_or_apartment']
    t.city = row ['city']
    t.postal_code = row ['postal_code']
    t.country = row ['country']

    t.save
end

100.times do 
    Customer.create!([{
        "company_description" => Faker::Lorem.paragraphs,
        "created_at" => Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name" => Faker::Company.unique.name,
        "company_address" => Faker::Name.building_address,
        "full_name_company_contact" => Faker::Name.unique.name,
        "company_contact_phone" => Faker::PhoneNumber.cell_phone,
        "company_contact_email" =>  Faker::Internet.email,
        "full_name_service_technical_authority" =>  Faker::Name.unique.name,
        "technical_authority_phone" => Faker::PhoneNumber.cell_phone,
        "technical_authority_email" => Faker::Internet.email,
        "user_id" => Faker::Number.between(from: 5, to:7)
    }])
end

100.times do 
    Building.create!([{
        "full_name_administrator" => Faker::Name.unique.name,
        "address_building" => Faker::Name.building_address,
        "email_administrator" => Faker::Internet.email,
        "phone_administrator" => Faker::PhoneNumber.cell_phone,
        "full_name_technical_contact_building" => Faker::Name.unique.name ,  
        "technical_contact_building_email" => Faker::Internet.email,
        "technical_contact_building_phone" => Faker::PhoneNumber.cell_phone,
        "customer_id" => Faker::Number.unique.between(from: 1, to:100)
    }])
end

100.times do 
    Battery.create!([{
        "information" => Faker::Lorem.sentences,
        "notes" => Faker::Lorem.sentences,
        "status" => Faker::Name.status,
        "building_id" => Faker::Number.between(from: 1, to:100),
        "battery_type" => Faker::Name.battery_type,
        "date_commissioning" =>Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "date_last_inspection" =>Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "certificate_of_operations" =>Faker::Code.nric 
    }])
end

200.times do 
    Column.create!([{
        "information" => Faker::Lorem.sentences,
        "notes" => Faker::Lorem.sentences,
        "battery_id" => Faker::Number.between(from: 1, to:100),
        "number_of_floors_served" => Faker::Number.between(from: 5, to: 20),
        "status" => Faker::Name.status_column,
        "column_type" => Faker::Name.battery_type
    }])
end

400.times do 
    Elevator.create!([{
        "serial_number" => Faker::Code.asin,
        "date_of_commissioning" => Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "date_of_last_inspection" => Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "certificate_of_inspection" =>Faker::Code.nric,
        "column_id" => Faker::Number.between(from: 1, to:200),
        "model" => Faker::Name.model,
        "status" => Faker::Name.status_elevator,
        "information" =>Faker::Lorem.sentences,
        "notes" => Faker::Lorem.sentences,
        "elevator_type" => Faker::Name.battery_type
    }])
end
    Quote.create!({
        "building_type" => "Residential",
        "number_of_apartments" => 200,
        "number_of_floors"=> 20,
        "number_of_basements"=> 3,
        "product_line"=> "Premium",
        "elevators_required"=> 2,
        "elevator_amount"=> 2,
        "elevator_unit_price"=> "12,345.00",
        "elevator_total_price"=> "24,690",
        "elevator_installation_fees"=> "3,209.7",
        "final_price"=> "27,899.7",
        "created_at"=> Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name"=> "Mcdonald",
        "email"=> "mcdo@jaifaim.com"
    })
    Quote.create!({
        "building_type" => "Residential",
        "number_of_apartments" => 400,
        "number_of_floors"=> 40,
        "number_of_basements"=> 3,
        "product_line"=> "Standard",
        "elevators_required"=> 4,
        "elevator_amount"=> 4,
        "elevator_unit_price"=> "7,565.00",
        "elevator_total_price"=> "30,260",
        "elevator_installation_fees"=> "3,026",
        "final_price"=> "33,286",
        "created_at"=> Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name"=> "Tim Horton",
        "email"=> "tim@jaivrmfaim.com"
    })
    Quote.create!({
        "building_type" => "Residential",
        "number_of_apartments" => 100,
        "number_of_floors"=> 10,
        "number_of_basements"=> 1,
        "product_line"=> "Excelium",
        "elevators_required"=> 2,
        "elevator_amount"=> 2,
        "elevator_unit_price"=> "15,400.00",
        "elevator_total_price"=> "30,800",
        "elevator_installation_fees"=> "4,928",
        "final_price"=> "35,728",
        "created_at"=> Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name"=> "Ashton",
        "email"=> "Ashton@jaivrmfaim.com"
    })
    Quote.create!({
        "building_type" => "Commercial",
        "number_of_elevators" => 4,
        "product_line"=> "Excelium",
        "elevators_required"=> 4,
        "elevator_amount"=> 4,
        "elevator_unit_price"=> "15,400.00",
        "elevator_total_price"=> "61,600",
        "elevator_installation_fees"=> "9,856",
        "final_price"=> "71,456",
        "created_at"=> Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name"=> "idk",
        "email"=> "idk@jaivrmfaim.com"
    })
    Quote.create!({
        "building_type" => "Commercial",
        "number_of_elevators" => 10,
        "product_line"=> "Premium",
        "elevators_required"=> 10,
        "elevator_amount"=> 10,
        "elevator_unit_price"=> "12,345.00",
        "elevator_total_price"=> "123,450",
        "elevator_installation_fees"=> "16,048.5",
        "final_price"=> "139,498.5",
        "created_at"=> Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name"=> "idgaf",
        "email"=> "idgaf@jaivrmfaim.com"
    })
    Quote.create!({
        "building_type" => "Commercial",
        "number_of_elevators" => 20,
        "product_line"=> "Standard",
        "elevators_required"=> 20,
        "elevator_amount"=> 20,
        "elevator_unit_price"=> "7,565.00",
        "elevator_total_price"=> "151,300",
        "elevator_installation_fees"=> "15,130",
        "final_price"=> "166,430",
        "created_at"=> Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name"=> "but like",
        "email"=> "but_like@jaivrmfaim.com"
    })
    Quote.create!({
        "building_type" => "Corporate",
        "maximum_occupancy" => 100,
        "product_line"=> "Standard",
        "number_of_floors"=> 200,
        "number_of_basements"=> 3,
        "elevators_required"=> 22,
        "elevator_amount"=> 22,
        "elevator_unit_price"=> "7,565.00",
        "elevator_total_price"=> "166,430",
        "elevator_installation_fees"=> "16,643",
        "final_price"=> "183,073",
        "created_at"=> Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name"=> "idfk",
        "email"=> "idfk@jaivrmfaim.com"
    })
    Quote.create!({
        "building_type" => "Corporate",
        "maximum_occupancy"=> 50,
        "product_line"=> "Excelium",
        "number_of_floors"=> 100,
        "number_of_basements"=> 3,
        "elevators_required"=> 6,
        "elevator_amount"=> 6,
        "elevator_unit_price"=> "15,400.00",
        "elevator_total_price"=> "92,400",
        "elevator_installation_fees"=> "14,784",
        "final_price"=> "107,184",
        "created_at"=> Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name"=> "idc",
        "email"=> "idc@jaivrmfaim.com"
    })
    Quote.create!({
        "building_type" => "Corporate",
        "maximum_occupancy" => 25,
        "product_line"=> "Premium",
        "number_of_floors"=> 50,
        "number_of_basements"=> 1,
        "elevators_required"=> 3,
        "elevator_amount"=> 3,
        "elevator_unit_price"=> "12,345.00",
        "elevator_total_price"=> "37,035",
        "elevator_installation_fees"=> "4,814.55",
        "final_price"=> "41,849.55",
        "created_at"=> Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name"=> "idfc",
        "email"=> "idfc@jaivrmfaim.com"
    })
    Quote.create!({
        "building_type" => "Hybrid",
        "maximum_occupancy" => 125,
        "product_line"=> "Premium",
        "number_of_floors"=> 250,
        "number_of_basements"=> 3,
        "elevators_required"=> 39,
        "elevator_amount"=> 39,
        "elevator_unit_price"=> "481,455",
        "elevator_total_price"=> "62,589.15",
        "elevator_installation_fees"=> "4,814.55",
        "final_price"=> "544,044.15",
        "created_at"=> Faker::Date.between(from: '2017-02-23', to: '2021-02-26'),
        "company_name"=> "ok",
        "email"=> "ok@jaivrmfaim.com"
    })

100.times do 
    Lead.create!([{
        "name" => Faker::Name.unique.name,
        "company_name" => Faker::Company.unique.name,
        "email" => Faker::Internet.email,
        "phone" => Faker::PhoneNumber.cell_phone,
        "project_name" => Faker::Lorem.sentence(word_count: 3),
        "project_description" => Faker::Lorem.sentences,
        "department" => Faker::Name.department,
        "message" => Faker::Lorem.sentences,
        "contact_request_date" => Faker::Time.between(from: '2017-02-23 12:30:59', to: DateTime.now)
    }])
end

Faker::UniqueGenerator.clear
100.times do
    BuildingDetail.create!([{
        "information_key" => { 
            "Contractor Name" => Faker::Name.unique.name
        },
        "building_id" => Faker::Number.unique.between(from: 1, to:100)
    }])
end
