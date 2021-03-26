class InterventionsController < ApplicationController
    require 'zendesk_api' 
    
    def building
        if params[:customer].present?
            @building = Building.where(customer_id:params[:customer])
        else
            @building = Building.all
        end

        respond_to do |format|
            format.json {
                render json: {building: @building}
            }
        end
    end

    def battery
        if params[:building].present?
            @battery = Battery.where(building_id:params[:building])
        else
            @battery = Battery.all
        end

        respond_to do |format|
            format.json {
                render json: {battery: @battery}
            }
        end
    end

    def column
        if params[:battery].present?
            @column = Column.where(battery_id:params[:battery])
          
           
        else
            @column = Column.all
        end

        respond_to do |format|
            format.json {
                render json: {column: @column}
                
            }
        end
    end

    def elevator
        if params[:column].present?
            @elevator = Elevator.where(column_id:params[:column])
        else
            @elevator = Elevator.all
        end

        respond_to do |format|
            format.json {
                render json: {elevator: @elevator}
                
            }
        end
    end


    def create
        @current_user_id = current_user.id 
        column = params[:column]
        elevator = params[:elevator]
        battery = params[:battery]
    
            @intervention = Intervention.new
               
                @intervention.author_id = current_user.id
                @intervention.customer_id = params[:customer]
                @intervention.building_id = params[:building]
                @intervention.employee_id = params[:employee]
                @intervention.report = params[:report]
                 
                #   when u selected a battery
                if (column == "None") then
                    # puts column == 'None'
                    @intervention.battery_id = battery
                    puts @intervention.battery_id
                    @intervention.column_id = nil
                    @intervention.elevator_id = nil
                   
                
                # when u selected a battery and column
        
                elsif (elevator == "None") then
                    @intervention.elevator_id = nil
                    @intervention.battery_id = nil
                    @intervention.column_id = column
            
                # when you select a battery, column and elevator 
                elsif (elevator != "None") then
                    @intervention.column_id = nil
                    @intervention.battery_id = nil
                    @intervention.elevator_id = elevator
                end  

        # employee = employee.find_by(current_user.id)
            
            @intervention.save!
              
              if @intervention.save
                create_intervention_ticket()
                flash[:notice] = "intervention successfull saved "
                # redirect_to '/admin/interventions'
                redirect_to root_path
              else
                flash[:notice] = "intervention not saved "
                redirect_to '/interventions'
                # redirect_to root_path
               
              end
           

    end
    def create_intervention_ticket
            client = ZendeskAPI::Client.new do |config|
                config.url = ENV['ZENDESK_URL']
                config.username = ENV['ZENDESK_USERNAME']
                config.token = ENV['ZENDESK_TOKEN']
            end
            
            ZendeskAPI::Ticket.create!(client, 
                :subject => "Building: #{@intervention.building_id}  require intervention", 
                :comment => { 
                    :value => 
                    "Customer Details:
                    The Customer Name: #{@intervention.customer.company_name}\n
                        Building ID: #{@intervention.building_id}\n
                        Battery ID: #{params[:battery]}\n
                        Column ID: #{if (params[:column] == "None") then "" else params[:column] end} 
                        Elevators ID: #{if (params[:elevator] == "None" ) then "" else params[:elevator] end}
                        #{if (@intervention.employee_id) then "The Assigned Technician:#{@intervention.employee.first_name} #{@intervention.employee.last_name}" end}
                        
                        Description:#{@intervention.report}"
                }, 
                :requester => { 
                    "name": Employee.find(@intervention.author_id).first_name+''+Employee.find(@intervention.author_id).last_name 
                },
                
                :type => "problem",
                :priority => "normal"
            )
    end 

    
    def show
        redirect_to '/admin/interventions'
    end
    def interventions
        render '/interventions/interventions'
    end

      private
    def intervention_params
        params.require(:interventions).permit(:customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :report)
    end
end


