class CreateProductsShelves < ActiveRecord::Migration[6.0]
  def change
    create_table :products_shelves, id: false do |t|
      t.belongs_to :shelf, null: false
      t.belongs_to :product, null: false

      t.timestamps
    end
  end
end
