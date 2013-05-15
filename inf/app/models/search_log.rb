class SearchLog < ActiveRecord::Base
  belongs_to :user
  attr_accessible :text, :user, :ip

  validates :text, presence: true
end
