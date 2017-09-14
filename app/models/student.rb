class Student < ActiveRecord::Base
    has_many :courses,:through => :enrolled
    has_many :enrolled
    belongs_to :user
    has_many :attempts
    
    # validates :id, uniqueness: true, presence: true
    # validates :user_id, presence: true
    
    # validates :user_id, presence: true
    # validates :first_name, presence: true
    # validates :last_name, presence: true
    # validates :year, presence: true
    # validates :degree, presence: true
    # validates_length_of :first_name, :minimum => 1, :maximum => 25
    # validates_length_of :last_name, :minimum => 1, :maximum => 25
    # validates_length_of :foo, :minimum => 1, :maximum => 12
    # validates_length_of :foo, :minimum => 4, :maximum => 35
    
    # validates_length_of :id,:maximum => 8
end
