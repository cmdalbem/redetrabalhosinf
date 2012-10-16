class Comment < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :person

  validates :text, :presence => true
  validates :person, :presence => true
  validates :tweet, :presence => true
end
