Rails.application.routes.draw do
  resources :companies do
    devise_for :users
  end
  devise_for :admins
  root 'home#top'
  get '/about'=> 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
