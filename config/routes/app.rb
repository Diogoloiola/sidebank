namespace :app, defaults: { format: :json } do
  namespace :v1 do
    resource :me, only: %w[show update], controller: 'me'
    resources :deposits, only: %w[index show create]
    resources :withdrawals, only: %w[index show create]
    resources :transfers, only: %w[index show create] do
      post 'refund', on: :member
    end
  end
end
