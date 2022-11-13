class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer :item_id	#商品ID
      t.integer :customer_id	#会員ID
      t.integer :amount	#数量

      t.timestamps
    end
  end
end
