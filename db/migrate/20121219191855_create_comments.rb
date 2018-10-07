class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :person_id
      t.string :text
      t.integer :project_id

      t.timestamps
    end
    add_index :comments, :person_id
    add_index :comments, :project_id
  end
end
