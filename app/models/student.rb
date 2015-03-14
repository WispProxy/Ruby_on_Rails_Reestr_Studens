class Student < ActiveRecord::Base
  belongs_to :group

  has_many :ratings
  has_many :subjects, through: :ratings

  attr_accessible :name, :surname, :group_id, :date_of_birth, :email, :registration_ip, :characteristic
  validates_presence_of :name, :surname, :group, :email, :registration_ip
  before_save :generate_random_characteristic



  scope :max_min_score, -> (min, max) {
    includes(:ratings)
        .group(:student_id)
        .having('AVG(ratings.rating) <= ? AND AVG(ratings.rating) >= ?', max, min)
  }
  scope :by_group, -> (group_name) {
    includes(:group)
        .where('groups.name = ?', group_name)
  }
  scope :by_semester, -> (semester) {
    includes(:group)
        .where('groups.semester = ?', semester)
  }


  def self.top_ten
    # Worked - all students with limit 10
    # students = Student.all.limit(10)

    # Worked SQL Query
    # students = <<-SQL
    #   SELECT * FROM students ;
    # SQL
    #
    # self.find_by_sql(students)

    # Need optimization and convert to Active Record
    # students = <<-SQL
    #   SELECT 	/*students.id,*/
    #     students.name,
    #     students.surname,
    #     students.date_of_birth,
    #     students.email,
    #     students.registration_ip,
    #     /*students.registration_time,*/
    #
    #     /*ratings.rating,*/
    #     (
    #       SELECT	ROUND(AVG(ratings.rating), 2) AS average_rating
    #       FROM	ratings
    #       WHERE	ratings.student_id = students.id
    #     ),
    #
    #     /*subjects.name,*/
    #
    #     groups.semester
    #
    #   FROM	students,
    #     ratings,
    #     subjects,
    #     groups
    #
    #   WHERE	groups.id = students.group_id
    #     AND
    #     students.id = ratings.student_id
    #     AND
    #     subjects.id = ratings.subject_id
    #     AND
    #     ratings.rating IS NOT NULL
    #
    #   ORDER BY average_rating DESC LIMIT 10 ;
    # SQL
    #
    # self.find_by_sql(students)

  end


  def average_rating
    ratings
        .average(:rating)
        .to_f
        .round(2)
  end

  def max_min_classmates name, min_score, max_score
    self.class.where(
                  group_id: self.group_id,
                  name:     name
    ).max_min_score(
         min_score,
         max_score
    )
  end



  private
    # Experimental function for characteristic!!!
    def generate_random_characteristic
      self.characteristic = Faker::Lorem.sentences(Random.rand(1..50)).join if Random.rand(9).even?
    end
end
