class CreatePersonProjectJoinTable < ActiveRecord::Migration
  def change
    create_table :people_projects, :id => false do |t|
      t.integer :person_id
      t.integer :project_id
    end
  end
end
