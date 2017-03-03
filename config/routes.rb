Rails.application.routes.draw do

  root 'home#top'
  get '/about'=> 'home#about'

devise_for :admins, :controllers => {
  :registrations => 'admins/registrations',
  :sessions => 'admins/sessions'
  }

devise_scope :user do
  get "sign_in", :to => "users/sessions#new"
  get "sign_out", :to => "users/sessions#destroy"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
