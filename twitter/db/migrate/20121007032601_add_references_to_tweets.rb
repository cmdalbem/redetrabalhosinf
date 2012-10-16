class AddReferencesToTweets < ActiveRecord::Migration
  def change
  	change_table :tweets do |t|
      t.references :person
    end
  end
end
