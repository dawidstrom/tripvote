class CreateVoteableItems < ActiveRecord::Migration[5.0]
  def change
    create_table :voteable_items do |t|
      t.integer :item_id
      t.string :item_type

      t.timestamps
    end
  end
end
