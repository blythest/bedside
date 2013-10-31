Bedside::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users
  resources :pages do
    resources :wishes, :posts, :page_participations, :visits, :appointments, :comments
  end
end