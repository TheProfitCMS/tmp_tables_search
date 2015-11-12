class CreateProductParams0Sets < ActiveRecord::Migration
  def change
    create_table :product_params0_sets do |t|
      t.string  :title, default: 'USB Flash Drive params'

      t.integer :size_x, default: 0
      t.integer :size_y, default: 0
      t.integer :size_z, default: 0

      t.integer :volume,      default: 512
      t.string  :volume_text, default: '512 Megabytes'

      t.string  :interface_1,   default: 'USB 2.0'
      t.string  :interface_2,   default: 'USB 3.0'

      t.timestamps null: false
    end
  end
end
