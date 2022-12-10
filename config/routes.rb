Rails.application.routes.draw do
  resources :urls
  get ':id', to: 'urls#redirect'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
