Pop::Application.routes.draw do
  resources :transactions

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, :skip => [:sessions]

  devise_scope :user do
    get 'sign_in', :to => 'home#outside', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  
  get 'inside' => 'home#inside', as: :inside
  get 'stamp' => 'home#stamp', as: :stamp

  root to: "home#outside"
end
