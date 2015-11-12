class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :title
      t.text   :content
      t.string :url
      t.string :state, default: :draft

      t.timestamps null: false
    end
  end
end
