class RemoveEmailFromPerson < ActiveRecord::Migration
  def up
    remove_column :people, :email
      end

  def down
    add_column :people, :email, :string
  end
end
