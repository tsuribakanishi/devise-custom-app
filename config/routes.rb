Rails.application.routes.draw do
  #resources :books
  devise_for :models
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books, only: [:index] do
    collection do
      get :search
    end
  end

end
