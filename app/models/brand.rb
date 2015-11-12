class Brand < ActiveRecord::Base
  has_many :products_brands_rels, dependent: :delete_all
  has_many :products, through: :products_brands_rels, source: :product

  include ::RailsShop::BrandStates
  include ::RailsShop::BrandProductsScopes
end
