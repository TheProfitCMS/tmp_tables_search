module RailsShop
  module ProductPriceScopes
    extend ActiveSupport::Concern

    included do
      scope :price_gt, ->(min_val = nil){
        where("products.price > ?", min_val)  if min_val
      }
      scope :price_lt, ->(max_val = nil){
        where("products.price < ?", max_val)  if max_val
      }
      scope :price_gteq, ->(min_val = nil){
        where("products.price >= ?", min_val) if min_val
      }
      scope :price_lteq, ->(max_val = nil){
        where("products.price <= ?", max_val) if max_val
      }
    end # included
  end
end