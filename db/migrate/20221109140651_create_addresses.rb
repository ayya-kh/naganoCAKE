class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :customer_id	#会員ID
      t.string :name	#宛名
      t.string :postal_code	#郵便番号
      t.string :address	#住所

      t.timestamps
    end
  end
end
