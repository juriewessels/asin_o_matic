class CreateProducts < ActiveRecord::Migration[5.1]

  def change
    create_table :products do |t|
      t.string :asin
      t.string :title
      t.integer :review_count
      t.float :price

      t.timestamps
    end
  end

end
