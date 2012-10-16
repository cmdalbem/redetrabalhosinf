class CommentsController < ApplicationController
	def create
		tweet = Tweet.find(params[:tweet_id])
		c = params[:comment]
	    p = Person.where(:name => c["person"])
	    @comment = tweet.comments.create(:text => c["text"], :person => p.first, :tweet => tweet)

    	redirect_to tweet_path(tweet)
    end
end
