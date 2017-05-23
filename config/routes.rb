Rails.application.routes.draw do
  resources :line_items do
    put 'decrement', on: :member
  end
  resources :carts
  root 'store#index', as: 'store/index'

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
