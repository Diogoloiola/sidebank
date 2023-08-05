Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins [
      'localhost:3000',
      'localhost:3001'
    ]

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[access-token expiry token-type uid client Content-Disposition]
  end
end
