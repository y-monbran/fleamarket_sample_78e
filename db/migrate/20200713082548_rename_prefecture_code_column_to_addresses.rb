class RenamePrefectureCodeColumnToAddresses < ActiveRecord::Migration[6.0]
  def change
    rename_column :addresses, :prefecture_code, :prefecture_code_id
  end
end
