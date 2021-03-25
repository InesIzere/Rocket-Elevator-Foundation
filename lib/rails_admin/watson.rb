require "ibm_watson"


module RailsAdmin
    module Config
      module Actions
        class Watson < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
  
          register_instance_option :root? do
            true
          end
          
          register_instance_option :breadcrumb_parent do
            nil
          end
          
          register_instance_option :auditing_versions_limit do
            100
          end
  
          register_instance_option :route_fragment do
            'watson.html.erb'
          end
  
          register_instance_option :link_icon do
            'icon-check'
          end
  
          register_instance_option :statistics? do
            false
          end
  
          register_instance_option :controller do
            proc do
                authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
                    apikey: ENV["TEXT_TO_SPEECH_IAM_APIKEY"]
                )
                text_to_speech = IBMWatson::TextToSpeechV1.new(
                    authenticator: authenticator
                )
                text_to_speech.service_url = ENV["TEXT_TO_SPEECH_URL"]
                
                message = "Greetings user #{current_user.id}. There are currently #{Elevator::count} elevators deployed in the #{Building::count} 
                buildings of your #{Customer::count} customers. Currently, #{Elevator.where(status: 'Intervention').count} elevators are not in Running Status 
                and are being serviced. You currently have #{Quote::count} quotes awaiting processing. You currently have #{Lead::count} leads in your contact 
                requests #{Battery::count} Batteries are deployed across #{Address.where(id: Building.select(:address_building).distinct).select(:city).distinct.count} cities."
                
                File.open("#{Rails.root}/public/speech.mp3", "wb") do |audio_file|
                    response = text_to_speech.synthesize(
                        text: message,
                        accept: "audio/mp3",
                        voice: "en-GB_CharlotteV3Voice"
                    ).result
                    puts response
                audio_file.write(response)
                end
            end
          end

        end
      end
    end
end      