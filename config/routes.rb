Rails.application.routes.draw do
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :cart, only: [:show] do
  	post "add", path: "add/:id"
  	get :checkout
  end
  root 'products#index'
end
