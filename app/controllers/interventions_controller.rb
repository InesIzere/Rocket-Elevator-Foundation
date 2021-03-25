class InterventionsController < ApplicationController
    
    
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
        end

        if params[:elevator] == "None"
            params[:elevator] = nil
        end
         
        if params[:employee] == "None"
            params[:employee] = nil
         end

         if params[:employee] == "None"
            params[:employee] = nil
         end
     
       
         
        if params[:elevator] != "None"
            params[:column] = nil 
            # params[:battery] = nil
            # @intervention.column_id = nil
            # @intervention.battery_id = nil
        elsif params[:column] != "None"
            # @intervention.battery_id = nil
        end  
       
        
       
         

        #  if interventions.save
        #         redirect_to '/'
           
        #   end
    
         @intervention = Intervention.new 
            @intervention = Intervention.create(
               
                author_id: @current_user_id,
                customer_id: params[:customer],
                building_id: params[:building],
                battery_id: params[:battery],
                column_id: params[:column],
                elevator_id: params[:elevator],
                employee_id: params[:employee],
                report: params[:report]
            )
            
            # @intervention.save!
              
              if @intervention.save
                flash[:notice] = "intervention successfull saved "
                redirect_to '/admin/interventions'
              else
                flash[:notice] = "intervention not saved "
                redirect_to '/admin/interventions'
               
              end
           

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


