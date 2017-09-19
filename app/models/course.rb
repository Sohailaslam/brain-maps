class Course < ActiveRecord::Base
    self.primary_key = :id
    belongs_to :user
    
    validates :id, uniqueness: true, presence: true
    validates :name, presence: true
    validates :user_id, presence: true
    validates_length_of :id,:maximum => 8
    
    has_many :students,:through => :enrolled
    has_many :enrolled,:dependent =>:destroy
    has_many :quizzes,:dependent =>:destroy
    has_many :learning_outcomes,:inverse_of => :course,:dependent =>:destroy
    
    accepts_nested_attributes_for :learning_outcomes, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
    
end
