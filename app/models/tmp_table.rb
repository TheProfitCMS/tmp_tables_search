# TmpTable.exists?('users')
# TmpTable.exists?('users-fake')

# sql = 'SELECT * FROM products'
# TmpTable.create('new_products', sql)
# TmpTable.exists?('tmp_new_products')

# klass = TmpTable.get_AR_class('new_products'){
#  include ::RailsShop::ProductStates
# }
# klass.count

# TmpTable.drop('new_products')

module TmpTable
  class << self
    def sql_exec(sql)
      ActiveRecord::Base.connection.execute sql
    end

    def create(tname, select_sql)
      sql_exec("CREATE TABLE #{ tname } AS #{ select_sql }")
    end

    def drop(tname)
      sql_exec("DROP TABLE #{ tname }")
    end

    def exists?(tname)
      begin
        sql_exec("SELECT * FROM #{ tname } LIMIT 1")
        true
      rescue
        false
      end
    end

    # "ProductCategory_1_products => @@ProductCategory1_products"
    def get_AR_class(name, &block)
      tmp_klass_name = name.classify
      tmp_table_name = tmp_klass_name.tableize
      var_name       = "@@#{ tmp_table_name }"

      return class_variable_get(var_name) if class_variable_defined?(var_name)
      return nil unless exists?(tmp_table_name)

      class_variable_set var_name, set_AR_klass(tmp_table_name, &block)
      class_variable_get var_name
    end

    def set_AR_klass(table_name, &block)
      klass = Class.new(ActiveRecord::Base){
        self.table_name = table_name
      }
      klass.class_eval &block
      klass
    end
  end
end