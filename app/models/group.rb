class Group < ActiveRecord::Base
	has_many :students

	attr_accessible :name, :semester
end
