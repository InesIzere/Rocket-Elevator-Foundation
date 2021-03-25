class TwilioText
    require 'twilio-ruby'
    attr_reader :message

    def initialize(message)
        @message = message
    end

    def txt
        client = Twilio::REST::Client.new Figaro.env.TWILIO_ACCOUNT_SID, Figaro.env.TWILIO_AUTH_TOKEN
        client.messages.create(
            from: Figaro.env.TWILIO_PHONE_NUMBER,
            to: '+15145037764',
            body: message
        )
    end
 end