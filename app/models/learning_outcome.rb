class LearningOutcome < ActiveRecord::Base
    belongs_to :course, :inverse_of => :learning_outcomes,:dependent =>:destroy
    has_many :questions
    
    validates_presence_of :course_id

end
