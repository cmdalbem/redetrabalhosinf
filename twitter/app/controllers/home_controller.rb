class HomeController < ApplicationController
  def show
  	@toptwitters = Person.all.sort { |x,y| y.tweets.size <=> x.tweets.size }
  	@topcommenters = Person.all.sort { |x,y| y.comments.size <=> x.comments.size }

  	render :action => 'show'
  end
end
