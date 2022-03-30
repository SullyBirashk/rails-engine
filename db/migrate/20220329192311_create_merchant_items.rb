class CreateMerchantItems < ActiveRecord::Migration[5.2]
  def change
    create_table :merchant_items do |t|
      t.bigint "merchant_id"
      t.bigint "item_id"

      t.timestamps
    end
  end
end
