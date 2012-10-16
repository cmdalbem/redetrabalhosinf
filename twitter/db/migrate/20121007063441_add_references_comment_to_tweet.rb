class AddReferencesCommentToTweet < ActiveRecord::Migration
  def change
  	change_table :tweets do |t|
      t.references :comment
    end
  end
end
