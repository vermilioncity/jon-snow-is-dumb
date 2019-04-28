class AddCommentableToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
    remove_reference :comments, :user
    remove_reference :comments, :article
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
