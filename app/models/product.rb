class Product < ActiveRecord::Base
  include ::RailsShop::ProductStates
  include ::RailsShop::ProductBrandsScopes
  include ::RailsShop::ProductPriceScopes

  class << self
    # Product

    def get_tmp_info_by id
    end

    def set_tmp_info_by id
    end

    def delete_tmp_info_by id
    end

    # Products

    def get_full_tmp_info
    end

    def set_tmp_info
    end

    def delete_tmp_info
    end
  end

  scope :max2min, ->(field = :id) { reorder("#{ field } DESC") if field && self.columns.map(&:name).include?(field.to_s) }
  scope :min2max, ->(field = :id) { reorder("#{ field } ASC")  if field && self.columns.map(&:name).include?(field.to_s) }

  scope :in_stock, ->{ where.not("products.amount" => 0) }

  scope :in_product_categories, ->(categories_ids = nil){
    categories_ids = Array.wrap(categories_ids)
    return nil if categories_ids.blank?

    joins(:product_category_relations)
    .where("product_category_relations.product_category_id" => categories_ids)
  }

  scope :without_product_categories, ->{
    joins("LEFT OUTER JOIN
      product_category_relations
      ON
      product_category_relations.product_id = products.id
    ")
    .group("products.id")
    .having("product_category_relations.id" => nil)
  }

  def self.params_types
    pluck('products.product_params_set_type').uniq
  end

  # rails g model product_params1_set title:string
  # rails g model product_params2_set title:string
  # rails g model product_params3_set title:string
  # rails g model product_params4_set title:string
  belongs_to :product_params_set, polymorphic: true

  has_many :product_category_relations
  has_many :product_categories, through: :product_category_relations

  def self.main_filter params
    params = params.with_indifferent_access

    brands     = params[:brands]
    price_min  = params[:price_min].to_f if params[:price_min]
    price_max  = params[:price_max].to_f if params[:price_max]
    categories = params[:categories]

    # select all products ids in this categories (can be a huge array)

    in_product_categories(categories)
    .includes(:product_categories)
    .with_brands_ids(brands)
    .price_gteq(price_min).price_lteq(price_max)
  end

  def self.products_full_data_sql
    params_joins = [0, 1].map do |id|
      str = <<-EOS.squish
        LEFT JOIN
          "product_params#{ id }_sets"
          ON
            "products"."product_params_set_type" = "ProductParams#{ id }Set"
            AND
            "products"."product_params_set_id" = "product_params#{ id }_sets"."id"
      EOS
    end.join(' ')


    q = <<-EOS.squish
      SELECT
        "products".*,

        #{ ProductsBrandsRel.join_fields },
        #{ ProductCategoryRelation.join_fields },

        #{ ProductParams0Set.join_fields },
        #{ ProductParams1Set.join_fields }

      FROM
        "products"

      LEFT JOIN
        "products_brands_rels"
        ON
          "products_brands_rels"."product_id" = "products"."id"

      #{ params_joins }
    EOS
  end

  scope :products_full_data, ->{
    q = products_full_data_sql
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

# Product.in_stock.without_product_categories.page(1).per(3)
