require 'machinist/active_record'

Group.blueprint do
	name { Faker::Lorem.word }
	semester { Random.rand(4) }
end

Rating.blueprint do
	student { Student.all.sample }
	subject
	rating { Random.rand(1..5) }
end

Student.blueprint do
	name    { Faker::Name.first_name }
	surname { Faker::Name.last_name  }
	group
	date_of_birth { Time.at(rand * Time.now.to_i) }
	email   { Faker::Internet.email  }
	registration_ip { Faker::Internet.ip_v4_address }
	characteristic { Faker::Lorem.sentences(1).join }
end
