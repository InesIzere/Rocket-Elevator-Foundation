# class InterventionsController < ApplicationController
 
  
#   def building
#       if params[:customer].present?
#           @building = Building.where(customer_id:params[:customer])
#       else
#           @building = Building.all
#       end

#       respond_to do |format|
#           format.json {
#               render json: {building: @building}
#           }
#       end
#   end

#   def battery
#       if params[:building].present?
#           @battery = Battery.where(building_id:params[:building])
#       else
#           @battery = Battery.all
#       end

#       respond_to do |format|
#           format.json {
#               render json: {battery: @battery}
#           }
#       end
#   end

#   def column
#       if params[:battery].present?
#           @column = Column.where(battery_id:params[:battery])
        
         
#       else
#           @column = Column.all
#       end

#       respond_to do |format|
#           format.json {
#               render json: {column: @column}
              
#           }
#       end
#   end

#   def elevator
#       if params[:column].present?
#           @elevator = Elevator.where(column_id:params[:column])
#       else
#           @elevator = Elevator.all
#       end

#       respond_to do |format|
#           format.json {
#               render json: {elevator: @elevator}
              
#           }
#       end
#   end
#    # @intervention.save!
           
#         # if(@intervention.column_id == "" && @intervention.elevator_id == "")then
#         #   @intervention.battery_id = params['batteryId']
#         # end
#      #create and Saving informations that are inside table intervention
#     def create
        
#         puts params
#         # @current_user_id = current_user.id 
#         @intervention = Intervention.new 
        
#         @intervention.author_id = current_user.id,
#         @intervention.customer_id = params[:customer],
#         @intervention.building_id = params[:building],

#         @intervention.battery_id = params[:battery],
#         @intervention.column_id = params[:column],
#         @intervention.elevator_id = params[:elevator],
#         @intervention.employee_id = params[:employee],
#         @intervention.report = params[:report]
        

#         if @intervention.save
#             flash[:notice] = "intervention successfull saved "
#             redirect_to '/admin/interventions'
#             else
#             flash[:notice] = "intervention not saved "
#             redirect_to '/interventions'
#             end
            
#         # if params[:column] == "None"
#         #     params[:column] = nil
#         # end

#         # if params[:elevator] == "None"
#         #     params[:elevator] = nil
#         # end
        
#         # if params[:employee] == "None"
#         #     params[:employee] = nil
#         # end

#         # if params[:employee] == "None"
#         #     params[:employee] = nil
#         # end
    
        
#         if params[:elevator] != "None"
#             params[:column] = nil 
#             # params[:battery] = nil
#             # @intervention.column_id = nil
#             # @intervention.battery_id = nil
#         elsif params[:column] != "None"
#             # @intervention.battery_id = nil
#         end  
          
                      
#     end

  
#     def show
#       redirect_to '/admin/interventions'
#     end
#     def interventions
#         render '/interventions/interventions'
#      end

#     private
#      #Requesting data from form - intervention.html.erb
#     def intervention_params
#       params.require(:interventions).permit(:author_id, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :report)
#     end
# end