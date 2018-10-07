class AddUserIdToSearchLog < ActiveRecord::Migration
  def change
    add_column :search_logs, :user_id, :integer
  end
end
