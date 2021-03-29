class InterventionsController < ApplicationController
    before_action :require_login
    def require_login
        if !current_user
          flash[:error] = "You must be logged in to access this section"
          redirect_to main_app.root_path # halts request cycle
        end
      end
    require 'zendesk_api' 
    # check the building that belongs that to a selected customer
    def building
        if params[:customer].present?
            @building = Building.where(customer_id:params[:customer])
        else
            @building = Building.all
        end
    #    Now i just need  to send back a json response, as well as handle the original html response.(same for battery and elevator)
        respond_to do |format|
            format.json {
                render json: {building: @building}
            }
        end
    end
  # check the batteries that belongs to that selected building
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
   # check the columns that belongs to the selected battery
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
    # check the elevators that belongs to the selected column
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
    # Create methods that used parameter coming
    # from our intervention form which the user has submitted.

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
                #  defined a statment that will only show a last selected option between battery, column and elevator.(nb:if-end statment dont work. must use if-elsif-end statment https://www.codecademy.com/forum_questions/52373a75548c3515940000dc)
                #   when u selected a battery only in database save column and elevators are nill
                if (column == "None") then
                    # puts column == 'None'
                    @intervention.battery_id = battery
                    # puts @intervention.battery_id
                    @intervention.column_id = nil
                    @intervention.elevator_id = nil
                   
                
                # when u selected a columnand a battery, in database battery and elevator are nil
        
                elsif (elevator == "None") then
                    @intervention.elevator_id = nil
                    @intervention.battery_id = nil
                    @intervention.column_id = column
            
                # when you select a battery, column and elevator you only save elevator other paramenters get nil values
                elsif (elevator != "None") then
                    @intervention.column_id = nil
                    @intervention.battery_id = nil
                    @intervention.elevator_id = elevator
                end  

        # employee = employee.find_by(current_user.id)
            
            # @intervention.save!
            # redirect_back fallback_location: root_path, notice: "Intervention Created"
            if @intervention.save
                create_intervention_ticket()
                redirect_back fallback_location: root_path, notice: "Intervention Created"
              end
            # #   if @intervention.save
            # #     create_intervention_ticket()
            # #     # flash[:notice] = "intervention successfull saved "
            # #     # redirect_to '/admin/interventions'
            # #     redirect_to root_path
            # #   else
            # #     flash[:notice] = "intervention not saved "
            # #     redirect_to '/interventions'
            # #     # redirect_to root_path
               
            # #   end
           

    end

    # zendesk function that send ticket after a form is filled.(must use if statment to brind back the values that are saved null otherwise the ticket have null values it'self)
    def create_intervention_ticket
            client = ZendeskAPI::Client.new do |config|
                config.url = ENV['ZENDESK_URL']
                config.username = ENV['ZENDESK_USERNAME']
                config.token = ENV['ZENDESK_TOKEN']
            end
            
            ZendeskAPI::Ticket.create!(client, 
                :subject => "Building: #{@intervention.building_id}  requires intervention", 
                :comment => { 
                    :value => 
                    "The Requester: #{Employee.find(@intervention.author_id).first_name+''+Employee.find(@intervention.author_id).last_name }
                    The Customer (Company Name): #{@intervention.customer.company_name}\n
                        Building ID: #{@intervention.building_id}\n
                        Battery ID: #{params[:battery]}\n
                        Column ID: #{if (params[:column] == "None") then "" else params[:column] end} 
                        Elevators ID: #{if (params[:elevator] == "None" ) then "" else params[:elevator] end}
                        #{if (@intervention.employee_id) then "The employee to be assigned to the task: #{@intervention.employee.first_name} #{@intervention.employee.last_name}" end}
                        
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
        # redirect_to '/admin/interventions'
    end
    def interventions
    # render '/interventions/interventions'
    end

      private

    #   this is must have the same value like the one in the form
    def intervention_params
        params.require(:interventions).permit(:customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :report)
    end
end


