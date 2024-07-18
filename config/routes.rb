Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'about', to: 'pages#about'
  get 'contributors', to: 'pages#contributors'
  resources :designs
  resources :researches
  resources :publications

  resources :designs do
    member do
      delete :remove_photo
    end
  end

  resources :researches do
    member do
      delete :remove_photo
    end
  end

  resources :publications do
    member do
      delete :remove_photo
    end
  end
end
