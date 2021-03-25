module RailsAdmin
    module Config
      module Actions
        class Starwars < RailsAdmin::Config::Actions::Base
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
            'starwars.html.erb'
          end
  
          register_instance_option :link_icon do
            'icon-music'
          end
  
          register_instance_option :statistics? do
            false
          end
  
  
          register_instance_option :controller do
            proc do
                authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
                    apikey: ENV["STAR_WARS_APIKEY"]
                )
                text_to_speech = IBMWatson::TextToSpeechV1.new(
                    authenticator: authenticator
                )
                text_to_speech.service_url = ENV["STAR_WARS_URL"]
                
                message = "Here are some interesting facts about Star Wars. Yoda was almost played by a monkey. Liam Neeson was too tall to play in the movies. R2D2 once spoke English, and was kind of a jerk."
                
                File.open("#{Rails.root}/public/facts.mp3", "wb") do |audio_file|
                    response = text_to_speech.synthesize(
                        text: message,
                        accept: "audio/mp3",
                        voice: "en-GB_JamesV3Voice"
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