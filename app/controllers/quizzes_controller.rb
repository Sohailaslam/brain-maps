class QuizzesController < ApplicationController

  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  before_action :set_course
  
  
  
  load_and_authorize_resource :course
  load_and_authorize_resource :quiz, :through => :course
  
  # GET /quizzes/1/results
  
  
    
    
    
    
    

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = @course.quizzes.all
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = @course.quizzes.new
    1.times do
      question = @quiz.questions.build
      4.times { question.answers.build }
  end
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = @course.quizzes.new(quiz_params)
    respond_to do |format|
      if @quiz.save
        format.html { redirect_to course_quiz_url(@course,@quiz), notice: 'Quiz was successfully created.' }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to course_quiz_url(@course,@quiz), notice: 'Quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to course_quizzes_url, notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end
    
    def set_course
      @course = Course.find(params[:course_id])
    end
    
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:name, :course_id, :status_type, :number_questions,questions_attributes:[:id,:content,:_destroy,:learning_outcome_id,answers_attributes:[:id,:content,:question_id,:is_correct]])
    end
end
