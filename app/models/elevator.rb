class Elevator < ApplicationRecord
    belongs_to :column , foreign_key: "column_id"
    after_update :contact_tech

    def contact_tech
        if self.status == "Intervention" or self.status == "intervention"
            message = "The Elevator, ID: #{self.id}, in building: #{self.column.battery.building.id}, on #{self.column.battery.building.address_building} needs maintenance"
            TwilioText.new(message).txt
        end
    end

    around_update :update_slack

    def update_slack
        notify = self.status_changed?
        if notify
            notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL']
            notifier.ping "The Elevator #{self.id} with Serial Number: #{self.serial_number} changed status from : #{self.status_was} to #{self.status}"
        end
    end
end