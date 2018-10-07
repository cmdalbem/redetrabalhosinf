class AddViewCountToProject < ActiveRecord::Migration
  def change
    add_column :projects, :viewCount, :integer, default: 0

  end
end
