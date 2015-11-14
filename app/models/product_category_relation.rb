class ProductCategoryRelation < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_category

  class << self
    def join_fields
      %w[ product_id product_category_id ].each do

      end
    end
  end

  validates :product, uniqueness: { scope: :product_category}
end
