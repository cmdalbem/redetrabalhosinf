class AddUserToPerson < ActiveRecord::Migration
  def change
    add_column :people, :user_id, :integer

  end
end
