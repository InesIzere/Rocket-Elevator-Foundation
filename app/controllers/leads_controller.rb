class LeadsController < ApplicationController
    # require 'sendgrid-ruby'
    require 'zendesk_api'
    include SendGrid

    def create

        puts params
        x = params[:attachment]

        leads = Lead.new
        leads.name = params[:name]
        leads.company_name = params[:company_name]
        leads.email = params[:email]
        leads.phone = params[:phone]
        leads.project_name = params[:project_name]
        leads.project_description = params[:project_description]
        leads.department = params[:department]
        leads.message = params[:message]
        leads.attachment = params[:attachment]

        $attachment = leads.attachment
        $company_name = leads.company_name

        # leads.save!
        
        
        if leads.save
        create_lead_ticket()
            sendgrid()
            if x == nil
                redirect_to '/'
            else
                redirect_to '/dropbox/auth_callback'
            end
        end

    end

    def create_lead_ticket
        client = ZendeskAPI::Client.new do |config|
            config.url = ENV['ZENDESK_URL']
            config.username = ENV['ZENDESK_USERNAME']
            config.token = ENV['ZENDESK_TOKEN']
        end
        ZendeskAPI::Ticket.create!(client, 
            :subject => "#{params[:name]} from #{params[:company_name]}", 
            :comment => { 
                :value => "The contact #{params[:name]} from company #{params[:company_name]} can be reached at email  #{params[:email]} and at phone number #{params[:phone]}. 
                    #{params[:department]} has a project named #{params[:project_name]} which would require contribution from Rocket Elevators.
                    \n\n
                    Project Description
                    #{params[:project_description]}\n\n
                    Attached Message: #{params[:message]}\n\n
                    The Contact uploaded an attachment"
            }, 
            :requester => { 
                "name": params[:name], 
                "email": params[:email] 
            },
            :priority => "normal",
            :type => "question"
        )
    end

    def sendgrid
        mail = Mail.new
        mail.from = Email.new(email: 'izere5@hotmail.com')
        custom = Personalization.new
        custom.add_to(Email.new(email: params[:email]))
        custom.add_dynamic_template_data({
            "fullName" => params[:name],
            "projectName" => params[:project_name]
        })
        mail.add_personalization(custom)
        mail.template_id = 'd-59a75423558c4723822ff5f15423c566'

        honda_civic = SendGrid::API.new(api_key: ENV['SENDGRID_API'])
        begin
            response = honda_civic.client.mail._('send').post(request_body: mail.to_json)
        rescue Exception => e
            puts e.message
        end
    end

    
    

    def leads_
        render '/'
    end

    def show
        redirect_to '/admin/lead'
    end


end
