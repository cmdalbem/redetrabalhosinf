class HomeController < ApplicationController
  def show
  	render :action => 'show'
  end

  def about
  	render :action => 'about'
  end
end
