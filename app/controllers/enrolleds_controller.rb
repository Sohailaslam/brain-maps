class EnrolledsController < ApplicationController
  before_action :set_enrolled, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /enrolleds
  # GET /enrolleds.json
  def index
    @enrolleds = Enrolled.all
  end

  # GET /enrolleds/1
  # GET /enrolleds/1.json
  def show
  end

  # GET /enrolleds/new
  def new
    @enrolled = Enrolled.new
  end

  # GET /enrolleds/1/edit
  def edit
  end

  # POST /enrolleds
  # POST /enrolleds.json
  def create
    @enrolled = Enrolled.new(enrolled_params)
    
    # puts "hello world",Student.exists?(user_id: params[:enrolled][:user_id])
    
    if Student.exists?(user_id: params[:enrolled][:user_id])
      # puts "we are here"
      student_id = Student.find_by_user_id(params[:enrolled][:user_id])
      @enrolled.student_id = student_id.id
      # student_id
      puts "enrolled", student_id
      
      respond_to do |format|
        if @enrolled.save
          format.html { redirect_to @enrolled, notice: 'Enrolled was successfully created.' }
          format.json { render :show, status: :created, location: @enrolled }
        else
          format.html { render :new }
          format.json { render json: @enrolled.errors, status: :unprocessable_entity }
        end
      end
    
    else
      # puts "we are in else"
      flash[:notice] = "Student does not exist"
      redirect_to new_enrolled_path
    end
  end

  # PATCH/PUT /enrolleds/1
  # PATCH/PUT /enrolleds/1.json
  def update
    respond_to do |format|
      if @enrolled.update(enrolled_params)
        format.html { redirect_to @enrolled, notice: 'Enrolled was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrolled }
      else
        format.html { render :edit }
        format.json { render json: @enrolled.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrolleds/1
  # DELETE /enrolleds/1.json
  def destroy
    @enrolled.destroy
    respond_to do |format|
      format.html { redirect_to enrolleds_url, notice: 'Enrolled was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrolled
      @enrolled = Enrolled.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrolled_params
      params.require(:enrolled).permit(:student_id, :course_id,:status_type,:user_id)
    end
end
