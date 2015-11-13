class ProductsController < ApplicationController
  def index
    page = params[:page]
    per  = params[:per]

    # categories: [1,2,3]
    # brands: [1, 4, 7, 11, 34, 35, 36, 37],

    _params = {
      # price_min: 50,
      # price_max: 150,
    }

    @brands = Brand.all
    @product_categories = ProductCategory.all
    @products = Product.main_filter(_params).min2max(:id).page(page).per(per)
  end
end
