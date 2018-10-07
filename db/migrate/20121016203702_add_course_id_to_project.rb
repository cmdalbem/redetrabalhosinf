class AddCourseIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :course_id, :integer, default: 1

  end
end
