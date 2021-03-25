class QuotesController < ApplicationController
    require 'zendesk_api'

    def create
        
      puts params
      quotes = Quote.new
      quotes.building_type = params[:building_type]
      quotes.number_of_apartments = params[:number_of_apartments]
      quotes.number_of_floors = params[:number_of_floors]
      quotes.number_of_elevators = params[:number_of_elevators]
      quotes.number_of_basements = params[:number_of_basements]
      quotes.maximum_occupancy = params[:maximum_occupancy]
      quotes.product_line = params[:product_line]
      quotes.elevators_required = params[:elevators_required]
      quotes.elevator_amount = params[:elevator_amount]
      quotes.elevator_unit_price = params[:elevator_unit_price]
      quotes.elevator_total_price = params[:elevator_total_price]
      quotes.elevator_installation_fees = params[:elevator_installation_fees]
      quotes.final_price = params[:final_price]
      quotes.company_name = params[:company_name]
      quotes.email = params[:email]
      # quotes.assign_attributes(quotes_params)
      quotes.save!
      
      
      if quotes.save
        create_quote_ticket()
        redirect_to '/pages/quote'
      end
    end

    def create_quote_ticket
      client = ZendeskAPI::Client.new do |config|
          config.url = ENV['ZENDESK_URL']
          config.username = ENV['ZENDESK_USERNAME']
          config.token = ENV['ZENDESK_TOKEN']
      end
      ZendeskAPI::Ticket.create!(client, 
          :subject => "#{params[:company_name]}", 
          :comment => { 
            :value => "#{params[:company_name]} can be reached at email #{params[:email]}. 
            Quote summary: \n 
            - Building type: #{params[:building_type]}
            - Appartments: #{params[:number_of_apartments]} 
            - Floors: #{params[:number_of_floors]}
            - Elevators:  #{params[:number_of_elevators]} 
            - Basements: #{params[:number_of_basements]}
            - Product Line: #{params[:product_line]} \n
            Number of suggested elevator is #{params[:elevator_amount]}. The unit price is #{params[:elevator_unit_price]}, installation fees is #{params[:elevator_installation_fees]}.
            Total price is #{params[:final_price]}. \n
            For More Information, refers to Quote #{params[:id]}."
            }, 
          :requester => { 
              "name": params[:company_name], 
              "email": params[:email]         
            },
          :priority => "normal",
          :type => "task"
        )
    end

    def quotes_
      render '/pages/quote'
    end

    def show
      redirect_to '/admin/quote'
    end

end
