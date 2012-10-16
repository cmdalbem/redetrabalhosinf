class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.references :tweet
      t.references :person

      t.timestamps
    end
    add_index :comments, :tweet_id
    add_index :comments, :person_id
  end
end
