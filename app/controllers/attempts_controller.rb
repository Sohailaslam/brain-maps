class AttemptsController < ApplicationController
  before_action :set_attempt, only: [:show, :edit, :update, :destroy]
  before_action :set_course
  before_action :set_quiz
  before_action :set_student
  # load_and_authorize_resource :except => [:results]
  
  
  
  
  
  
  def results
    
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_questions = @quiz.questions
    # student = Student.find_by_user_id(current_user.id)
    # @attempt = student.attempts.find_by_quiz_id(@quiz.id)
    @attempt = Attempt.find(params[:attempt_id])
    if(@attempt.nil?)
      flash[:notice] = 'You Have not attempted the quiz'
      redirect_to course_quizzes_path(@course)
    else
      @responses = @attempt.responses
    end
        
  end
    

  # GET /attempts
  # GET /attempts.json
  def index
    @attempts = Attempt.all
  end

  # GET /attempts/1
  # GET /attempts/1.json
  def show
  end

  # GET /attempts/new
  def new
    @attempt = Attempt.new
    # @quiz.questions.count.times
    # @attempt.responses.new
  end

  # GET /attempts/1/edit
  def edit
    @resp = @attempt.responses
  end

  # POST /attempts
  # POST /attempts.json
  def create
    @attempt = Attempt.new(attempt_params)

    respond_to do |format|
      if @attempt.save
        format.html { redirect_to course_quiz_results_url(@course,@quiz), notice: 'Quiz Responses successfully submitted' }
        format.json { render :show, status: :created, location: @attempt }
      else
        format.html { render :new }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attempts/1
  # PATCH/PUT /attempts/1.json
  def update
    respond_to do |format|
      if @attempt.update(attempt_params)
        format.html { redirect_to course_quiz_results_url(@course,@quiz), notice: 'Quiz Responses successfully updated.' }
        format.json { render :show, status: :ok, location: @attempt }
      else
        format.html { render :edit }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attempts/1
  # DELETE /attempts/1.json
  def destroy
    @attempt.destroy
    respond_to do |format|
      format.html { redirect_to attempts_url, notice: 'Attempt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attempt
      @attempt = Attempt.find(params[:id])
    end
    
    def set_quiz
      @quiz = Quiz.find(params[:quiz_id])
    end
    def set_course
      @course = Course.find(params[:course_id])
    end
    
    def set_student
      puts "we are here"
      if(!(current_user.nil?) and (current_user.student?))
        @stu = Student.find_by_user_id(current_user.id)
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def attempt_params
      params.require(:attempt).permit(:student_id, :number_of_attempts, :quiz_id,responses_attributes:[:id,:question_id,:answer_id,:student_id,:is_selected,:attempt_id])
    end
end
