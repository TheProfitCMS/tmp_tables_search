class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :title
      t.decimal :price, precision: 8, scale: 2
      t.integer :amount, default: 0
      t.string  :state, default: :draft

      t.references :product_params_set, polymorphic: true

      t.timestamps null: false
    end
  end
end
