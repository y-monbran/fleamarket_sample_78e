class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.integer :postage_payer_id, null: false
      t.integer :item_condition_id, null: false
      t.integer :prefecture_code_id, null: false
      t.integer :preparation_day_id, null: false
      t.bigint :category_id, null: false, foreign_key: true
      t.references :seller, null:false
      # , foreign_key: { to_table: :users }
      t.references :buyer, null:false
      # , foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end