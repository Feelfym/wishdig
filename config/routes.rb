Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
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

  resource :tutorial, only: [] do
    get 'step1'
    patch 'update_step1'
    get 'step2'
    patch 'update_step2'
    get 'step3'
    patch 'update_step3'
  end

  resources :comparisons, only: [:show, :new, :create, :index, :destroy] do
    resources :notes, only: [:create, :destroy]
  end

end
