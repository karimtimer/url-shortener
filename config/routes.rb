Rails.application.routes.draw do
  resources :urls
  get ':id', to: 'urls#redirect'

  root to: 'urls#index'
end
