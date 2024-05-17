# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'  # In development, you might set this to '*'
                   # In production, replace '*' with your frontend domain
      resource '*',
               headers: :any,
               methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end
  