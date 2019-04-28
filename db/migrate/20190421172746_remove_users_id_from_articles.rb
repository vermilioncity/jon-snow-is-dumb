class RemoveUsersIdFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :users_id, :string
  end
end
