class AddResetToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
    add_reference :articles, :user, foreign_key: true
  end
end
