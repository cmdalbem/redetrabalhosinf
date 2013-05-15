class AddIpToSearchLog < ActiveRecord::Migration
  def change
    add_column :search_logs, :ip, :string
  end
end
