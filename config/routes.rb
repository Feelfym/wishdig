Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: redirect('/items')
  resources :items do
    resources :memos, only: [:create, :destroy]
    collection do
      get :purchased
    end
    member do
      patch :purchase
    end
  end

  resources :comparisons, only: [:show, :new, :create, :index, :destroy] do
    resources :notes, only: [:create, :destroy]
  end

end
