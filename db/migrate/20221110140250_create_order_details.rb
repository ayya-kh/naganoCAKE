class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id #注文ID
      t.integer :item_id #商品ID
      t.integer :price #購入時価格
      t.integer :amount #数量
      t.integer :making_status #製造ステータス

      t.timestamps
    end
  end
end
