class SearchLog < ActiveRecord::Base
  belongs_to :user
  attr_accessible :text, :user, :ip, :resultsCount

  validates :text, presence: true
end
