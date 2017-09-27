class Enrolled < ActiveRecord::Base
    enum status_type: [ :inactive, :active ]
    belongs_to :course
    belongs_to :student
    
    
    attr_accessor :user_id
    # validates :student_id, presence: true
    validates :user_id, presence: true
    validates :course_id, presence: true
    # validates_length_of :id,:maximum => 8
    
    
    
    
    
    # validate :student_id_should_be_valid
    
    # def student_id_should_be_valid
    #     if(not(Student.exists? id: self.student_id))
    #         errors.add(:student_id, "Student does not exist in database")
    #     end
        
    # end

#     def expiration_date_cannot_be_in_the_past
#     if expiration_date.present? && expiration_date < Date.today
#       errors.add(:expiration_date, "can't be in the past")
#     end
#   end
end
