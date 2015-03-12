class StudentsController < ApplicationController
	before_filter { @students = Student.includes([:group, :subjects]).top_ten }

	def index
		respond_to do |format|
			format.js { render json: @students }
			format.html
		end
	end

	def create
		student = Student.new params[:student]
		student.registration_ip = request.remote_ip

		if student.save
			render json: @students
		else
			render text: student.errors.full_messages.join(', '), status: 406
		end
	end

end
