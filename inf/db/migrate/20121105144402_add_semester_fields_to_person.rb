class AddSemesterFieldsToPerson < ActiveRecord::Migration
  def up
    add_column :people, :semester_year, :integer

    add_column :people, :semester_sem, :integer

    Person.all.each do |p|
    	sem = p.barra.split('/')
    	p.update_attributes!(semester_year: sem[0], semester_sem: sem[1] )
    end

    remove_column :people, :barra
  end

  def down
  	add_column :people, :barra, :string

	Person.all.each do |p|
    	p.update_attributes!(barra: p.semester)
    end

	remove_column :people, :semester_year
    remove_column :people, :semester_sem
  end

end
