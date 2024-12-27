Rails.application.routes.draw do
  # Existing routes
  devise_for :users
  resources :products
  resource :cart, only: [:show] do
    post 'add_item/:product_id', to: 'carts#add_item', as: 'add_item'
    delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
  end
  root "products#index"
end

