class ProductCategory < ActiveRecord::Base
  has_many :product_category_relations
  has_many :products, through: :product_category_relations

  # sql = Product.products_full_data_sql
  # ProductCategory.first.create_tmp_products_table(sql)

  def create_tmp_products_table(sql)
    tname = self.class.table_name
    tmp_klass = "tmp_#{ tname }_#{ id }_products".classify
    tmp_table = tmp_klass.tableize

    TmpTable.create(tmp_table, sql)
  end

  def get_tmp_products_table
    tname = self.class.table_name
    tmp_klass = "tmp_#{ tname }_#{ id }_products".classify
    tmp_table = tmp_klass.tableize

    TmpTable.get_AR_class(tmp_table){
      include ::RailsShop::ProductStates
      include ::RailsShop::ProductPriceScopes
    }
  end

  # ProductCategory.first.drop_tmp_products_table
  def drop_tmp_products_table
    tname = self.class.table_name
    tmp_klass = "tmp_#{ tname }_#{ id }_products".classify
    tmp_table = tmp_klass.tableize

    TmpTable.drop(tmp_table)
  end
end

# ProductCategory.first.create_tmp_products_table('SELECT * FROM products')
# klass = ProductCategory.first.get_tmp_products_table
# ProductCategory.first.drop_tmp_products_table
