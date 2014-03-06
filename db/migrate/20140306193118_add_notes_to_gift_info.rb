class AddNotesToGiftInfo < ActiveRecord::Migration
  def change
    add_column :gift_infos, :note, :text
  end
end
