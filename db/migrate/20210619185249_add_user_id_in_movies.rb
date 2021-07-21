class AddUserIdInMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :user_id, :int
    add_column :books, :user_id, :int
  end
end
