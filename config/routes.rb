Rails.application.routes.draw do
  root 'products#index'
  devise_for :users
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :cart, only: [:show] do
  	# post "add", path: "add/:id"
  	post "add/:id", :as => "add", :action => "add"
  	get :checkout
  end
  resources :orders, only: [ :index, :show, :create]
end
