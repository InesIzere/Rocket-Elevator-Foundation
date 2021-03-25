require 'pg'
namespace :intervention do

    desc "Sync Fact Intervention"
    task sync: :environment  do |t, args|
        dwh = PG::Connection.new(host:'codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com', port:'5432', dbname:'rocketelevators_dwh_team_sirine', user:'codeboxx', password:'Codeboxx1!')
        # puts dwh
        result = ["Success", "Failure", "Incomplete"]
        status = ["Pending", "In progress", "Interrupted", "Resumed", "Complete"]
        
        def new_intervention (employeeID, buildingID, batteryID, columnID, elevatorID, startDate, endDate, result, report, status)
            dwh = PG::Connection.new(host:'codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com', port:'5432', dbname:'rocketelevators_dwh_team_sirine', user:'codeboxx', password:'Codeboxx1!')
            dwh.exec_params(
                "INSERT INTO fact_interventions (employee_id, building_id, battery_id, column_id, elevator_id, start_of_intervention, end_of_intervention, result, report, status) 
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)", 
                [employeeID, buildingID, batteryID, columnID, elevatorID, startDate, endDate, result, report, status]
            )
        end

        dwh.exec("TRUNCATE fact_interventions")
        Building.all.each do |building|
            # Battery Intervention
            building.batteries.all.each do |battery|
                if battery.status.downcase == "intervention"
                    random_startDate = Time.at(rand(battery.date_commissioning.to_datetime..DateTime.now).to_datetime).to_datetime
                    random_endDate = Time.at(rand(random_startDate..DateTime.now).to_datetime).to_datetime
                    random_result = result[rand(0...result.length)]
                    if random_result.downcase == "success"
                        
                        random_status = "Complete"
                        random_report = "The Battery is functionnal and ready to operate"

                    elsif random_result.downcase == "failure"
                        
                        random_status = "Interrupted"
                        random_report = "BRUH That shit BROKE"

                    else

                        random_endDate = nil
                        random_status = status[rand(0...3)]

                    end
                    new_intervention(rand(1...7), building.id, battery.id, nil, nil, random_startDate, random_endDate, random_result, random_report, random_status)
                end

                # Column Intervention
                battery.columns.all.each do |column|
                    if column.status.downcase == "intervention"
                        random_startDate = Time.at(rand(battery.date_commissioning.to_datetime..DateTime.now).to_datetime).to_datetime
                        random_endDate = Time.at(rand(random_startDate..DateTime.now).to_datetime).to_datetime
                        random_result = result[rand(0...result.length)]
                        if random_result.downcase == "success"
                        
                            random_status = "Complete"
                            random_report = "The Column is functionnal and ready to operate"

                        elsif random_result.downcase == "failure"
                        
                            random_status = "Interrupted"
                            random_report = "BRUH That Shit BROKE"

                        else

                            random_endDate = nil
                            random_status = status[rand(0...3)]
                        end
                        new_intervention(rand(1...7), building.id, battery.id, column.id, nil, random_startDate, random_endDate, random_result, random_report, random_status)
                    end

                    # Elevator Intervention
                    column.elevators.all.each do |elevator|
                        if elevator.status.downcase == "intervention"
                            random_startDate = Time.at(rand(battery.date_commissioning.to_datetime..DateTime.now).to_datetime).to_datetime
                            random_endDate = Time.at(rand(random_startDate..DateTime.now).to_datetime).to_datetime
                            random_result = result[rand(0...result.length)]
                            if random_result.downcase == "success"
                        
                                random_status = "Complete"
                                random_report = "The Elevator is functionnal and ready to operate"

                            elsif random_result.downcase == "failure"
                        
                                random_status = "Interrupted"
                                random_report = "BRUH That shit BROKE"

                            else

                                random_endDate = nil
                                random_status = status[rand(0...3)]
                            end
                            new_intervention(rand(1...7), building.id, battery.id, column.id, elevator.id, random_startDate, random_endDate, random_result, random_report, random_status)
                        end
                    end
                end
            end
        end
    end
end