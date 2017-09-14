class Response < ActiveRecord::Base
    belongs_to :question
    belongs_to :answer
    belongs_to :student
    before_save :check_response
    
    def check_response
        # question_id = self.question_id
        answer = Answer.find(self.answer_id)
        if(answer.is_correct)
            self.is_correct = true
        else
            self.is_correct = false
        end
        true #callback should return true to process transaction
        
    end

end
