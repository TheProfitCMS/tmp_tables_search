Rails.application.routes.draw do
  root 'products#index'
  resources :product_categories do
    collection do
      get :without_categories
    end
  end
end
