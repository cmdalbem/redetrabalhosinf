class AddAvatarPathToPerson < ActiveRecord::Migration
  def change
    add_column :people, :avatarPath, :string

  end
end
