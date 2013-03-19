class Ownership < ActiveRecord::Base
  belongs_to :person
  belongs_to :project
  # attr_accessible :title, :body
end
