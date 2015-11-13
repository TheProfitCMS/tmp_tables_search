Rails.application.routes.draw do
  root 'products#index'
  resources :product_categories
end
