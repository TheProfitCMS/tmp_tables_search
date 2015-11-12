module RailsShop
  module ProductBrandsScopes
    extend ActiveSupport::Concern

    included do
      scope :with_brands_ids, ->(brands_ids = []){
        joins(:products_brands_rels)
        .where("products_brands_rels.brand_id" => Array.wrap(brands_ids))
      }

      scope :with_brands, ->{
        joins(:products_brands_rels)
        .select('products.*')
        .group('products.id')
        .having("COUNT( products_brands_rels.brand_id ) > 0")
      }

      scope :without_brands, ->{
        # find ids of products without relations to brands
        q = <<-EOS.squish
          SELECT
            "products".id
          FROM
            "products"
          LEFT OUTER JOIN
            "products_brands_rels"
            ON
              "products_brands_rels"."product_id" = "products"."id"
          GROUP BY
            "products".id
          HAVING
            "products_brands_rels".id IS NULL;
        EOS

        _ids = connection.select_value(q)
        where(id: _ids)
      }

      scope :with_brands_count, ->(count = 0){
        return without_brands if count.zero?

        joins(:products_brands_rels)
        .group('products.id')
        .having("COUNT( products_brands_rels.brand_id ) = #{ count }")
      }
    end
  end
end