class RemoveDetailsFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_reference :items, :seller, null: false
    remove_reference :items, :buyer, null: false
  end
end
