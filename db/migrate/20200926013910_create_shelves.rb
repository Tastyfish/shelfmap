class CreateShelves < ActiveRecord::Migration[6.0]
  def change
    create_table :shelves do |t|
      t.string :name, null: false
      t.integer :x_position, null: false
      t.integer :y_position, null: false

      t.timestamps
    end
  end
end
