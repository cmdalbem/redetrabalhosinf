class AddDownloadCountToProject < ActiveRecord::Migration
  def change
    add_column :projects, :downloadCount, :integer, default: 0

  end
end
