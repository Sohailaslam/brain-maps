class Course < ActiveRecord::Base
    self.primary_key = :id
    belongs_to :user
    
    validates :id, uniqueness: true, presence: true
    validates :name, presence: true
    validates :user_id, presence: true
    validates_length_of :id,:maximum => 8
    
    has_many :students,:through => :enrolled
    has_many :enrolled
    has_many :quiz
    
end
