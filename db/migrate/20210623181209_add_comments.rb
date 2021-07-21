class AddComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :description
      t.integer :post_id
      t.integer :user_id
    end
  end
end
