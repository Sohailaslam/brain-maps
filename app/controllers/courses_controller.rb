class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /courses
  # GET /courses.json
  def index
    
    # @courses = Course.all
    
    if(current_user.present? && current_user.educator?)
      # educator = Educator.where(user_id: current_user.id).first.id
      @courses = Course.where(user_id: current_user.id )
    elsif(current_user.present? && current_user.student?)
      puts 'we are in stduent'
      @student = Student.where(user_id:current_user.id).first
      @courses= @student.courses
       
    end
    
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    
  end

  # GET /courses/new
  def new
    @course = Course.new
    @learning_outcome = @course.learning_outcomes.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    
    if(current_user.educator?)
      puts
      @course.user_id = current_user.id
    end
    

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    
    if(current_user.educator?)
      # puts
      @course.user_id = current_user.id
    end
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:id,:user_id,:name,:stduent_id,:status,learning_outcomes_attributes:[:id,:_destroy,:course_id,:title])
      # params.require(:educator).permit(:user_id, :name, :role)
    end
end
