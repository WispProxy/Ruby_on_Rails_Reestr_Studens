class StudentsController < ApplicationController
  before_filter { @students = Student.top_ten }

  # Worked block - output all students!
  #before_filter { @students = Student.all }

	def index
		respond_to do |format|
			format.js { render json: @students }
			format.html
		end
	end

	def create
		student = Student.new params[:student]
		student.registration_ip = request.remote_ip
    student.registration_time = Time.now

		if student.save
			render json: @students
		else
			render text: student.errors.full_messages.join(', ')
		end
	end

end
