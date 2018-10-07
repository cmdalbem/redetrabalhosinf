class RemoveDefaultValueFromProjectCourse < ActiveRecord::Migration
  def up
  	change_column_default(:projects, :course_id, nil)
  end

  def down
  	change_column_default(:projects, :course_id, 1)
  end
end
