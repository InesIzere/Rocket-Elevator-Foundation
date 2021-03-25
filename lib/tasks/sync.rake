require 'pg'
namespace :warehouse do

    desc "Sync to data warehouse"
    task sync: :environment  do |t, args|

        dwh = PG::Connection.new(host:'codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com', port:'5432', dbname:'rocketelevators_dwh_team_sirine', user:'codeboxx', password:'Codeboxx1!')

        dwh.exec("TRUNCATE fact_quotes")
        dwh.prepare('to_fact_quotes', "INSERT INTO fact_quotes (quote_id, creation_date, company_name, email, nb_elevator, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)")
        Quote.all.each do |quote|
            dwh.exec_prepared('to_fact_quotes', [quote.id, quote.created_at, quote.company_name, quote.email, quote.elevator_amount])
        end


        dwh.exec("TRUNCATE fact_contacts")
        dwh.prepare('to_fact_contacts', "INSERT INTO fact_contacts (contact_id, creation_date, company_name, email, project_name, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)")
        Lead.all.each do |lead|
            dwh.exec_prepared('to_fact_contacts', [lead.id, lead.contact_request_date, lead.company_name, lead.email, lead.project_name])
        end


        dwh.exec("TRUNCATE fact_elevators ")
        dwh.prepare('to_fact_elevators', "INSERT INTO fact_elevators (serial_number, date_of_commissioning, building_id, customer_id, building_city, created_at, updated_at) VALUES ($1,$2,$3,$4,$5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)")
        Elevator.all.each do |elevator|
            a = elevator.serial_number
            b = elevator.date_of_commissioning
            c = elevator.column.battery.building_id
            d = elevator.column.battery.building.customer.id
            e = elevator.column.battery.building.address_building
            dwh.exec_prepared('to_fact_elevators', [a,b,c,d,e])
        end

        
        dwh.exec("TRUNCATE dim_customers")
        dwh.prepare('to_dim_customers', "INSERT INTO dim_customers (creation_date, company_name, full_name_company_contact, email_company_conctact, nb_elevator, customer_city, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, $6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)")
        Customer.all.each do |customer|
            nb_elevators = 2
            customer.buildings.all.each do |building|
                building.batteries.all.each do |battery|
                    battery.columns.all.each do |column|
                        nb_elevators += column.elevators.count
                    end
                end
            end
            dwh.exec_prepared('to_dim_customers', [customer.created_at, customer.company_name, customer.full_name_company_contact, customer.company_contact_email, nb_elevators, customer.company_address])
        end

    end
end
