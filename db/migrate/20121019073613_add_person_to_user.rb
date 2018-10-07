class AddPersonToUser < ActiveRecord::Migration
  def change
    add_column :users, :person_id, :integer

  end
end
