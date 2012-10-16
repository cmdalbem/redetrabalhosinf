class AddReplyChainToTweets < ActiveRecord::Migration
  def change
  	change_table :tweets do |t|
      t.references :tweet
    end
  end
end
