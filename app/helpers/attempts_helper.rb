module AttemptsHelper
    
    def class_results(quiz)
        all_quiz_attempts = quiz.attempts
        score_hash = Hash.new
        all_quiz_attempts.each do |attempt|
            attempt_correct_responses = attempt.responses.where(is_correct:true).count #score for each attempt
            student = Student.find(attempt.student_id).user_id
            score_hash[student] = attempt_correct_responses
        end
        return score_hash
        
    end
    
    def question_wise_average_marks(quiz)
        all_questions = quiz.questions
        all_questions.each do |question|
            question_responses = question.responses
            total_responses = question_responses.count
            # need to calculate scores question wise
        end
        
    end
    
    def learning_outcome_wise_avg(quiz)
        all_questions = quiz.questions
        score_hash = Hash.new
        all_questions.each do |question|
            learning_outcome = question.learning_outcome.title
            score_hash[learning_outcome] = 0
        end
        
        all_questions.each do |question|
            question_responses_count = question.responses.count.to_f
            learning_outcome = question.learning_outcome.title
            question_responses__correct_count = question.responses.where(is_correct:true).count.to_f
            score_hash[learning_outcome] = question_responses__correct_count/question_responses_count
        end
        
        return score_hash
    end
    
    def check_student_attempted_quiz(quiz)
    end
    
end
