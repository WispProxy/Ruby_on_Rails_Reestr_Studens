class Student < ActiveRecord::Base
  # TODO: add OPTIMISTIC LOCK TABLE for students table!
  # TODO: verify dublicates SQL-query
  # TODO: optimization SQL-query for #top_ten

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
  scope :by_surname, -> (surname) {
    where('students.surname = ?', surname)
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
    students = <<-SQL
      SELECT 	students.id,
              students.name,
              students.surname,
              students.date_of_birth,
              students.email,
              students.registration_ip,
              /*students.registration_time,*/

              /*ratings.rating,*/
              (
                SELECT	ROUND(AVG(ratings.rating), 2) AS average_rating
                FROM	ratings
                WHERE	ratings.student_id = students.id
              ),

              /*subjects.name,*/

              groups.semester

      FROM	  students,
              ratings,
              subjects,
              groups

      WHERE	  groups.id = students.group_id
              AND
              students.id = ratings.student_id
              AND
              subjects.id = ratings.subject_id
              AND
              ratings.rating IS NOT NULL

      ORDER BY average_rating DESC LIMIT 10 ;
    SQL

    self.find_by_sql(students)


    # Experiments with Active Record
    # for optimization sql-query
    #1#Student.select(:name).distinct.order('students.name DESC')
    #2#distinct.order('students.name DESC').limit(5)
    #3#students = Student.all(:all, include: :ratings).group('ratings.student_id').order('AVG(ratings.rating) DESC').limit(10)
    #4$students = includes(:ratings).order("ratings.student_id").references(:ratings).limit(10)
  end

  # This method for average rating
  def average_rating
    ratings
        .average(:rating)
        .to_f
        .round(2)
  end

  # This method for max-min
  def max_min_classmates name, min_score, max_score
    self.class.where(
                  group_id: self.group_id,
                  name:     name
    ).max_min_score(
         min_score,
         max_score
    )
  end

  # This method for find students by IP address with not empty characteristics
  def self.students_with_ip_and_characteristics
    students_with_ip_and_characteristics = where(registration_ip: select(:registration_ip)
                                              .group(:registration_ip)
                                              .having('COUNT(*) > 1'))
                                              .where('characteristic IS NOT NULL')
  end


  private
    # Experimental function for characteristic!!!
    def generate_random_characteristic
      self.characteristic = Faker::Lorem.sentences(Random.rand(1..50)).join if Random.rand(9).even?
    end
end
