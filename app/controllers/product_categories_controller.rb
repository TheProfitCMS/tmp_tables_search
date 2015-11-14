class ProductCategoriesController < ApplicationController
  def show
    page = params[:page]
    per  = params[:per]

    @product_category = ProductCategory.find(params[:id])

    _params = {
      brands: [1,2,3],
      categories: [ @product_category.id ]
    }

    @brands       = Brand.all
    @products     = Product.main_filter(_params).includes(:brands).min2max(:id).page(page).per(per)
    @params_types = Product.main_filter(_params).params_types
  end

  def without_categories
    page = params[:page]
    per  = params[:per]

    @brands   = Brand.all
    @products = Product.without_product_categories.includes(:product_categories).min2max(:id).page(page).per(per)
  end
end