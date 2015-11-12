class ProductsBrandsRel < ActiveRecord::Base
  belongs_to :product
  belongs_to :brand

  validates :product, uniqueness: { scope: :brand }
end
