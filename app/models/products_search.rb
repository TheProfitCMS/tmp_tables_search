class ProductsSearch < ActiveRecord::Base

  class << self
    # ProductsSearch.products_search_sql
    def conn_exec(sql)
      ActiveRecord::Base.connection.execute(sql)
    end

    def products_search_sql
      q = <<-EOS.squish
        SELECT
          "products"."id"                       AS "p_id",
          "products"."title"                    AS "p_title",
          "products"."price"                    AS "p_price",
          "products"."amount"                   AS "p_amount",
          "products"."state"                    AS "p_state",
          "products"."product_params_set_id"    AS "p_product_params_set_id",
          "products"."product_params_set_type"  AS "p_product_params_set_type",
          "products"."created_at"               AS "p_created_at",
          "products"."updated_at"               AS "p_updated_at",

          "products_brands_rels"."product_id" AS "pb_product_id",
          "products_brands_rels"."brand_id"   AS "pb_brand_id",

          "product_category_relations"."product_id"          AS "pc_product_id",
          "product_category_relations"."product_category_id" AS "pc_product_category_id",

          "product_params0_sets"."size_x"      AS "pp0_size_x",
          "product_params0_sets"."size_y"      AS "pp0_size_y",
          "product_params0_sets"."size_z"      AS "pp0_size_z",
          "product_params0_sets"."volume"      AS "pp0_volume",
          "product_params0_sets"."interface_1" AS "pp0_interface_1",
          "product_params0_sets"."interface_2" AS "pp0_interface_2",

          "product_params1_sets"."processor_type" AS "pp1_processor_type",
          "product_params1_sets"."display_size"   AS "pp1_display_size",
          "product_params1_sets"."weight"         AS "pp1_weight"

        FROM
          "products"

        LEFT OUTER JOIN
          "products_brands_rels"
          ON
            "products_brands_rels"."product_id" = "products"."id"

        LEFT OUTER JOIN
          "product_category_relations"
          ON
            "product_category_relations"."product_id" = "products"."id"

        LEFT OUTER JOIN
          "product_params0_sets"
          ON
            "products"."product_params_set_type" = 'ProductParams0Set'
            AND
            "products"."product_params_set_id" = "product_params0_sets"."id"

        LEFT OUTER JOIN
          "product_params1_sets"
          ON
            "products"."product_params_set_type" = 'ProductParams1Set'
            AND
            "products"."product_params_set_id" = "product_params1_sets"."id"

      EOS
    end

    def insert_fields
      [
        :p_id,
        :p_title,
        :p_price,
        :p_amount,
        :p_state,
        :p_product_params_set_id,
        :p_product_params_set_type,
        :p_created_at,
        :p_updated_at,

        :pb_product_id,
        :pb_brand_id,

        :pc_product_id,
        :pc_product_category_id,

        :pp0_size_x,
        :pp0_size_y,
        :pp0_size_z,
        :pp0_volume,
        :pp0_interface_1,
        :pp0_interface_2,

        :pp1_processor_type,
        :pp1_display_size,
        :pp1_weight
      ]
    end

    # ProductsSearch.products_search_build_all
    def products_search_build_all
      select_all = products_search_sql
      fields     = insert_fields.join(', ')

      q = <<-EOS.squish
        INSERT INTO #{ table_name }
        (#{ fields })
        (#{ select_all })
      EOS

      conn_exec(q)
    end

    # ProductsSearch.delete_products_from_search(1)
    def delete_products_from_search product_ids
      product_ids = Array.wrap product_ids
      return nil if product_ids.blank?

      delete_all(p_id: product_ids)
    end

    # ProductsSearch.add_products_to_search(1)
    def add_products_to_search product_ids
      product_ids = Array.wrap product_ids
      return nil if product_ids.blank?

      fields      = insert_fields.join(', ')
      product_ids = product_ids.join(',')
      select_all  = products_search_sql

      q = <<-EOS.squish
        INSERT INTO #{ table_name }
        (#{ fields })
        (
          #{ select_all }
          WHERE "products"."id" IN (#{ product_ids })
        )
      EOS

      conn_exec(q)
    end
  end # class << self
end