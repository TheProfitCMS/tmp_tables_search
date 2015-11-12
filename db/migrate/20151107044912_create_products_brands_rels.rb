class CreateProductsBrandsRels < ActiveRecord::Migration
  def change
    create_table :products_brands_rels do |t|
      t.integer :product_id
      t.integer :brand_id

      t.timestamps null: false
    end
  end
end
