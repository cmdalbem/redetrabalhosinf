class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.references :person
      t.references :project

      t.timestamps
    end
    add_index :ownerships, :person_id
    add_index :ownerships, :project_id
  end
end
