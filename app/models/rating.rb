class Rating < ActiveRecord::Base
  belongs_to :student
  belongs_to :subject

  attr_accessible :rating
  validates_presence_of :subject, :student, :rating
end
