class Product < ActiveRecord::Base
  has_many :products_brands_rels, dependent: :delete_all
  has_many :brands, through: :products_brands_rels, source: :brand

  include ::RailsShop::BrandStates
  include ::RailsShop::ProductBrandsScopes
  include ::RailsShop::ProductPriceScopes

  scope :in_stock, ->{
    where.not("products.amount" => 0)
  }

  # rails g model product_params1_set title:string
  belongs_to :product_params_set, polymorphic: true

  scope :custom_query, ->{
    q = <<-EOS.squish
      SELECT
        "products"."id",
        "products"."product_params_set_type",

        "product_params0_sets"."size_x",
        "product_params0_sets"."size_y",
        "product_params0_sets"."size_z",

        "product_params1_sets"."processor_type"

      FROM
        "products"

      LEFT OUTER JOIN
        "product_params0_sets"
        ON
          "products"."product_params_set_type" = "ProductParams0Set"
          AND
          "products"."product_params_set_id" = "product_params0_sets"."id"

      LEFT OUTER JOIN
        "product_params1_sets"
        ON
          "products"."product_params_set_type" = "ProductParams1Set"
          AND
          "products"."product_params_set_id" = "product_params1_sets"."id"

      WHERE
        "product_params1_sets"."processor_type" = 'A7'
        OR
        "product_params0_sets"."size_x" = '1'
      ;
    EOS

    find_by_sql(q)
  }
end

# DOC:
#
# `Select with state scopes:`
#
# Product.published.count
#
# `Select with Brand scopes:`
#
# Product.draft.without_brands.page(3).per(2)
#
# Product.published.with_brands.page(3).per(2)
# Product.published.with_brands_count(1).page(3).per(2)
# Product.published.with_brands_count(3).page(3).per(2).to_a.first.brands.count
#
# Product.published.with_brands_ids([2, 3]).page(2).per(2).count
#
# `Select with Price scopes:`
#
# Product.published.price_gteq.count
# Product.published.with_brands_ids([1,2,3]).price_gteq(100).price_lteq(500).count
# Product.published.with_brands_ids([1,2,3]).price_gteq.price_lteq(1000).page(2).per(1).count
# Product.published.with_brands_ids([1,2,3]).price_gteq(0).price_lteq(1000).page(2).per(1).count
#
# Product.published.in_stock.with_brands_ids([1,2,3]).price_gteq(0).price_lteq(1000).page(2).per(1)
#
# `Select with Custom Params:`
#
# => processor_type: "A7"
