class AddSemesterFieldsToProject < ActiveRecord::Migration
  def up
    add_column :projects, :semester_year, :integer

    add_column :projects, :semester_sem, :integer

    Project.all.each do |p|
    	sem = p.barra.split('/')
    	p.update_attributes!(semester_year: sem[0].to_i, semester_sem: sem[1].to_i )
    end

    remove_column :projects, :barra
  end

  def down
  	add_column :projects, :barra, :string

	Project.all.each do |p|
    	p.update_attributes!(barra: p.semester)
    end

	remove_column :projects, :semester_year
    remove_column :projects, :semester_sem
  end

end
