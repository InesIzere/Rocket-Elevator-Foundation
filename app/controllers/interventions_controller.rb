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
    

        if params[:column] == "None"
            params[:column] = nil
            # params[:battery]=
        end

        if params[:elevator] == "None"
            params[:elevator] = nil
            params[:battery] = nil
        end
         
        if params[:employee] == "None"
            params[:employee] = nil
         end

         if params[:employee] == "None"
            params[:employee] = nil
         end
     
       
         
        if params[:elevator] != "None"
            params[:column] = nil 
            params[:battery] = nil
        #     # @intervention.column_id = nil
        #     # @intervention.battery_id = nil
        # elsif params[:column] != "None"
        #     # @intervention.battery_id = nil
        end  
        
        
        
       
         

        #  if interventions.save
        #         redirect_to '/'
           
        #   end
    
        #  @intervention = Intervention.new 
            @intervention = Intervention.new({
               
                author_id: current_user.id,
                customer_id: params[:customer],
                building_id: params[:building],
                battery_id: params[:battery],
                column_id: params[:column],
                elevator_id: params[:elevator],
                employee_id: params[:employee],
                report: params[:report]

               
            })


            
            # @intervention.save!
              
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
                :subject => "Intervention is required at #{@intervention.building_id} ", 
                :comment => { 
                    :value => "Please Note That:
                    The Customer: #{@intervention.customer.company_name}\n, 
                     whose Building ID: #{@intervention.building_id}\n
                    whith Battery ID: #{@intervention.battery_id}\n
                    , Column ID: #{@intervention.column_id}\n
                    and  Elevator ID:#{@intervention.elevator_id}\n
                   need intervention asap. Employee: #{@intervention.employee_id}\n
                    is required to go there. Here are more datils Description: #{@intervention.report}"
                }, 
                :requester => { 
                    # "name": @intervention.current_user.first_name, 
                    # "name": @intervention.employee.last_name,
                    # "#{@intervention.current_user.first_name} #{@intervention.current_user.last_name}", 
                },
                :priority => "normal",
                :type => "problem"
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


