module RailsShop
  module ProductBrandsScopes
    extend ActiveSupport::Concern

    included do
      has_many :products_brands_rels, dependent: :delete_all
      has_many :brands, through: :products_brands_rels, source: :brand

      scope :with_brands_ids, ->(brands_ids = []){
        brands_ids = Array.wrap(brands_ids)
        return nil if brands_ids.blank?

        joins(:products_brands_rels)
        .where("products_brands_rels.brand_id" => Array.wrap(brands_ids))
      }

      scope :with_brands, ->{
        joins(:products_brands_rels)
        .group("#{ table_name }.id")
        .having("COUNT( products_brands_rels.brand_id ) > 0")
      }

      scope :without_brands, ->{
        joins("
          LEFT OUTER JOIN products_brands_rels
          ON
          products_brands_rels.product_id = #{ table_name }.id
        ")
        .group("#{ table_name }.id")
        .having("products_brands_rels.id" => nil)
      }

      scope :with_brands_count, ->(count = 0){
        return without_brands if count.zero?

        joins(:products_brands_rels)
        .group('#{ table_name }.id')
        .having("COUNT( products_brands_rels.brand_id ) = ?", count)
      }
    end
  end
end