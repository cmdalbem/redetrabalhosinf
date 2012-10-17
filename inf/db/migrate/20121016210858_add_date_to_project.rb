class AddDateToProject < ActiveRecord::Migration
  def change
    add_column :projects, :date, :date

  end
end
