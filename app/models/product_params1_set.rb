class ProductParams1Set < ActiveRecord::Base
  has_one :product, as: :product_params_set
end
