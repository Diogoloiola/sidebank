namespace :app, defaults: { format: :json } do
  namespace :v1 do
    resource :me, only: %w[show update], controller: 'me'
  end
end
