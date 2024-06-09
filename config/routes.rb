Rails.application.routes.draw do
  root to: "items#index"
  resources :items do
    collection do
      get "completepost"
    end
  end
end
