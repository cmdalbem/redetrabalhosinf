class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.references :project

      t.timestamps
    end
  end
end
