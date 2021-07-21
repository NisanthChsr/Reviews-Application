class AddColumnInCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :isReviewable, :boolean
  end
end
