class ChangeNickColumnFromPerson < ActiveRecord::Migration
  def up
  	change_column_default(:people, :nick, nil)
  end

  def down
  	change_column_default(:people, :nick, "nick")
  end
end
