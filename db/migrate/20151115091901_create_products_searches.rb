class CreateProductsSearches < ActiveRecord::Migration
  def change
    create_table :products_searches do |t|
      # PRODUCTS, PREFIX: P
      t.integer  :p_id
      t.string   :p_title
      t.decimal  :p_price,   precision: 8, scale: 2
      t.integer  :p_amount,  default: 0
      t.string   :p_state

      t.integer  :p_product_params_set_id
      t.string   :p_product_params_set_type

      t.datetime :p_created_at, null: false
      t.datetime :p_updated_at, null: false

      # PRODUCTS/BRANDS RELATIONS, PREFIX: PB
      t.integer :pb_product_id
      t.integer :pb_brand_id

      # PRODUCTS/CATEGORIES RELATIONS, PREFIX: PC
      t.integer :pc_product_id
      t.integer :pc_product_category_id

      # PRODUCT PARAMS 0, PREFIX: pp0
      t.integer  :pp0_size_x
      t.integer  :pp0_size_y
      t.integer  :pp0_size_z

      t.integer  :pp0_volume
      t.string   :pp0_interface_1
      t.string   :pp0_interface_2

      # PRODUCT PARAMS 1, PREFIX: pp1
      t.string  :pp1_processor_type
      t.decimal :pp1_display_size,   precision: 8, scale: 2
      t.decimal :pp1_weight,         precision: 8, scale: 2
    end
  end
end
