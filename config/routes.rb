Rails.application.routes.draw do
  resources :companies do
    resources :surveys do
      member do
        post 'text_create'
        post 'select_create'
        get 'result'
      end
      resources :questions, only: [:show] do
        member do
          post 'create_answer_text'
          post 'create_answer_select'
        end
      end
    end
    devise_for :users, skip: [:confirmations, :sessions], controllers: {
      registrations: 'users/registrations'
    }
    devise_scope :user do
      get 'new_chief' => 'users/registrations#new_chief'
      post 'create_chief' => 'users/registrations#create_chief'
    end
    resources :rooms, only: [:show, :index] do
      resources :chats, only: :create
    end
    resources :users, only: :show
  end
  devise_for :users, skip: [:registrations, :passwords], controllers: {
    confirmations: 'users/confirmations'
  }
  devise_for :admins
  root 'home#top'
  get '/about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount API::Root => '/'
end
