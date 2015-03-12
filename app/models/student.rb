class Student < ActiveRecord::Base
  belongs_to :group

  has_many :ratings
  has_many :subjects, through: :ratings

  attr_accessible :name, :surname, :group_id, :date_of_birth, :email, :registration_ip, :characteristic
  validates_presence_of :name, :surname, :group, :email, :registration_ip
  before_save :generate_random_characteristic



  def self.top_ten
  # TODO: TOP 10!
  end

  def average_rating
  #   TODO: AVARAGE RATING!
  end

  def specific_classmates name, min_score, max_score
  #   TODO: THIS METHOD!
  end

  def self.registered_with_special_ip
  #   TODO: REGISTRATION WITH CLIENT IP-ADDRESS!
  end



  private
    # Experimental function for characteristic!!!
    def generate_random_characteristic
      self.characteristic = Faker::Lorem.sentences(Random.rand(1..255)).join if Random.rand(9).even?
    end
end
