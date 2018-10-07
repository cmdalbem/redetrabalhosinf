class Link < ActiveRecord::Base
  belongs_to :project
  attr_accessible :url, :hits
end
