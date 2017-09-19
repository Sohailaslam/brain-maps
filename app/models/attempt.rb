class Attempt < ActiveRecord::Base
    has_many :responses, :dependent => :destroy
    belongs_to :student
    belongs_to :quiz
    
    # validates_uniqueness_of :student_id, :scope => {:quiz_id,message: "You have already attempted the quiz" }
    
    validates :student_id, uniqueness: { scope: :quiz_id, message: "You have already attempted the quiz" }
    
    accepts_nested_attributes_for :responses
    # , :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
    
    
    def self.graph(inp)
        hash = Hash.new
        query = sanitize_sql(['SELECT a.id as attempt_id,a.quiz_id as quiz_id,r.id as response_id,r.question_id as question_id,q.learning_outcome_id as learning_outcome_id, r.is_correct as is_correct,lo.title as learning_outcome_name FROM learning_outcomes lo,attempts a,responses r,questions q WHERE lo.id = q.learning_outcome_id AND a.id=? AND a.id=r.attempt_id AND q.id =r.question_id',inp])
        query_result= connection.select_all(query)
        group = query_result.group_by {|item| item["learning_outcome_name"]}.each do |key,value|
            hash[key] = 0
            value.each do |question|
                if (question["is_correct"]==1)
                    hash[key] +=1
                end
            end
        end
        return hash
        # ActiveRecord::Base.connection.exec_query("SELECT * FROM attempts a WHERE a.id=?",23).first
    end
end