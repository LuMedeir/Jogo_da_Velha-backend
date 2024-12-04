# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # ou defina o domínio do seu frontend aqui (ex: 'http://localhost:8080')

    resource '/game/*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete],
      credentials: false
  end
end