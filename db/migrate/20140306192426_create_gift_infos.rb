class CreateGiftInfos < ActiveRecord::Migration
  def change
    create_table :gift_infos do |t|
      t.string :from_name
      t.string :from_email

      t.string :to_name
      t.string :to_email

      t.integer :order_id
      t.timestamps
    end
  end
end
