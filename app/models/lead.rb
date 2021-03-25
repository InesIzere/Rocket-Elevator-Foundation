class Lead < ApplicationRecord
    require 'sendgrid-ruby'
    include SendGrid
    mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
end
