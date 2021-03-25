# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins '*'

#     resource '*',
#     headers: :any,
#     method: [:get, :post, :put, :patch, :option, :delete, :head, :put] 
#   end
# end