class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :user_id, :int
    remove_column :movies, :user_id, :int
  end
end
