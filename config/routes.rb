require 'sidekiq/web'
Rails.application.routes.draw do  
  mount Sidekiq::Web => '/sidekiq'

  resources :templates do
    member do
      get 'preview'
    end
    resources :translation_texts, path: :translations
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
end
