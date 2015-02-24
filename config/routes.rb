Rails.application.routes.draw do
  resources :index, only: :index
  resources :parsings, except: [:edit, :update] do
    get :parse, on: :member
  end

  root 'home#index'
end
