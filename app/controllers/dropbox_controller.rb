class DropboxController < ApplicationController         
    def auth_callback
        client = DropboxApi::Client.new(ENV['DROPBOX_TOKEN'])
        client_id = ENV['DROPBOX_ID']
        client_secret = ENV['DROPBOX_SECRET']

        company_name = $company_name.to_s
        path = "/" + $company_name + ""
        file = IO.read File.join(Rails.root, 'public', $attachment.to_s)

        attachment_path = $attachment.to_s
        new_path = attachment_path.partition('/uploads/lead/attachment/').last
        new_path2 = path + "/" + new_path.partition('/').last

        DropboxApi::Authenticator.new(client_id, client_secret)

        begin
            client.get_metadata path
        rescue DropboxApi::Errors::NotFoundError
            client.create_folder path
            client.upload new_path2, file

            ActiveRecord::Base.connection.exec_query("UPDATE leads SET attachment = NULL WHERE company_name = '#{company_name}'")
        else
            client.upload new_path2, file

            ActiveRecord::Base.connection.exec_query("UPDATE leads SET attachment = NULL WHERE company_name = '#{company_name}'")
        end

        redirect_to '/'
    end
end
