class Attempt < ActiveRecord::Base
    has_many :responses, :dependent => :destroy
    belongs_to :student
    belongs_to :quiz
    
    # validates_uniqueness_of :student_id, :scope => {:quiz_id,message: "You have already attempted the quiz" }
    
    validates :student_id, uniqueness: { scope: :quiz_id, message: "You have already attempted the quiz" }
    
    accepts_nested_attributes_for :responses
    # , :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
    
    
    def graph(inp)
        query = sanitize_sql(['SELECT * FROM attempts a WHERE a.id=?',inp])
        connection.exec_query(query)
        # ActiveRecord::Base.sanitize_sql.connection.exec_query("SELECT * FROM attempts a WHERE a.id=?",23).first
    end
end