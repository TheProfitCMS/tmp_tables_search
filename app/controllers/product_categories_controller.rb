class ProductCategoriesController < ApplicationController
  def show
    page = params[:page]
    per  = params[:per]

    @product_category = ProductCategory.find(params[:id])

    _params = {
      categories: [ @product_category.id ]
    }

    @brands = Brand.all
    @products = Product.main_filter(_params).min2max(:id).page(page).per(per)
  end
end
