namespace :web do
  namespace :v1 do
    resources :customers, only: %i[create]
  end
end
