module RailsShop
  module BrandProductsScopes
    extend ActiveSupport::Concern

    included do
      scope :with_products, ->{
        joins(:products_brands_rels)
        .group("brands.id")
        .having("COUNT( products_brands_rels.product_id ) > 0")
      }

      scope :without_products, ->{
        joins("
          LEFT OUTER JOIN products_brands_rels
          ON
            products_brands_rels.brand_id = brands.id
        ")
        .group("brands.id")
        .having("products_brands_rels.id" => nil)
      }

      scope :with_products_count, ->(count = 0){
        return without_products if count.zero?

        joins(:products_brands_rels)
        .group('brands.id')
        .having("COUNT( products_brands_rels.product_id ) = ?", count)
      }
    end
  end
end