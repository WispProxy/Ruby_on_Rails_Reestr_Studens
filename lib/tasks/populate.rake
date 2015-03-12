namespace :db do
	desc "Populate database with sample data."

	def random_times from, to
		Range.new(from, to).to_a.sample.times yield
	end

	task :populate => :environment do
		require 'machinist'
		require Rails.root.join 'spec', 'blueprints.rb'

		['English language', 'Mathematics', 'Economics', 'Chemistry', 'Concepts of Modern Natural Sciences'].each do |subj|
			Subject.create name: subj
		end

		3.times   { Group.make! }
		5.times   { Student.make! group: Group.all.sample }
		10.times  { Rating.make! student: Student.all.sample, subject: Subject.all.sample }

		Student.last.update_attributes registration_ip: Student.first.registration_ip
		Student.all[1].update_attributes registration_ip: Student.first.registration_ip

		puts 'Population is done'
	end

	# task :clear => :environment do
	# 	[Student, Rating, Group, Subject].each &:delete_all
	# 	puts 'Clear is done'
	# end
	#
	# task :repopulate => [:clear, :populate]

end
