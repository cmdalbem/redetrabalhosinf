class AddNickToPerson < ActiveRecord::Migration
  def change
    add_column :people, :nick, :string, default: "nick"

  end
end
