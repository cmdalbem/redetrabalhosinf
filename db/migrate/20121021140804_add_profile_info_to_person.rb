class AddProfileInfoToPerson < ActiveRecord::Migration
  def change
    add_column :people, :barra, :string

    add_column :people, :about, :string

    add_column :people, :personal_link, :string

  end
end
