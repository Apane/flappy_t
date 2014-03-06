class ChangeGiftInfoForeignKey < ActiveRecord::Migration
  def change
    change_column :gift_infos, :order_id, :string
  end
end