module RailsShop
  module BrandProductsScopes
    extend ActiveSupport::Concern

    included do
      scope :with_products, ->{
        joins(:products_brands_rels)
        .select('brands.*')
        .group('brands.id')
        .having("COUNT( products_brands_rels.product_id ) > 0")
      }

      scope :without_products, ->{
        # find ids of brands without relations to products
        q = <<-EOS.squish
          SELECT
            "brands".id
          FROM
            "brands"
          LEFT OUTER JOIN
            "products_brands_rels"
            ON
              "products_brands_rels"."brand_id" = "brands"."id"
          GROUP BY
            "brands".id
          HAVING
            "products_brands_rels".id IS NULL;
        EOS

        _ids = connection.select_value(q)
        where(id: _ids)
      }

      scope :with_products_count, ->(count = 0){
        return without_products if count.zero?

        joins(:products_brands_rels)
        .group('brands.id')
        .having("COUNT( products_brands_rels.product_id ) = #{ count }")
      }
    end
  end
end