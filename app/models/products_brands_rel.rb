class ProductsBrandsRel < ActiveRecord::Base
  belongs_to :product
  belongs_to :brand

  class << self
    def join_fields
      column = 'brand_id'
      "#{ table_name }.#{ column } AS #{ column }"
    end
  end

  validates :product, uniqueness: { scope: :brand }
end
