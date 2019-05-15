class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
    authorize @subjects
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    authorize @subject
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
    authorize @subject
  end

  # GET /subjects/1/edit
  def edit
    authorize @subject
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)
    authorize @subject
    respond_to do |format|
      if @subject.save && verify_recaptcha(model: @subject)
        format.js { flash.now[:notice] = "Đã thêm môn học thành công." }
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    authorize @subject
    respond_to do |format|
      if @subject.update(subject_params)
        format.js { flash.now[:notice] = "Đã cập nhật môn học thành công." }
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    authorize @subject
    @subject.destroy
    respond_to do |format|
      format.js { flash.now[:notice] = "Xóa môn học thành công." }
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name)
    end
end
