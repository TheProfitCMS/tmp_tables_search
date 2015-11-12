class CreateProductParams1Sets < ActiveRecord::Migration
  def change
    create_table :product_params1_sets do |t|
      t.string :title, default: 'Notebooks params'

      t.string  :processor_type, default: ''
      t.decimal :display_size, precision: 8, scale: 2
      t.decimal :weight, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
