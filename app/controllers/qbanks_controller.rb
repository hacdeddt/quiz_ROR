class QbanksController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy, :delete, :qbank_params]
  after_action :approval, only: [:update]

  def index
  	@qbanks = Qbank.all
  end

  def show
  end

  def new
  	@qbank = Qbank.new
  	@subjects = Subject.all
  	@categories = Category.all
  end

  def create
  	@subjects = Subject.all
  	@categories = Category.all
    @qbank = Qbank.new(qbank_params)

    respond_to do |format|
      if @qbank.save && verify_recaptcha(model: @qbank)
        format.html { redirect_to user_qbanks_path(current_user), notice: 'Thêm câu hỏi thành công.' }
        format.json { render :show, status: :created, location: @qbank }
      else
        format.html { render :new }
        format.json { render json: @qbank.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @qbank.user
    authorize current_user
    @subjects = Subject.all
    @categories = Category.all
  end

  def update
    authorize @qbank.user
    authorize current_user
  	@subjects = Subject.all
  	@categories = Category.all
    respond_to do |format|
      if @qbank.update(qbank_params) && verify_recaptcha(model: @qbank)
        format.html { redirect_to user_qbanks_path(current_user), notice: 'Cập nhật câu hỏi thành công.' }
        format.json { render :show, status: :ok, location: @qbank }
      else
        format.html { render :edit }
        format.json { render json: @qbank.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    authorize @qbank.user
    authorize current_user
    @qbank.update(is_delete: 1)
    respond_to do |format|
      format.html { redirect_to user_qbanks_path(current_user), notice: 'Đã xóa câu hỏi.' }
      format.json { head :no_content }
    end
  end

  def destroy
  	if (current_user.role)
	    @qbank.destroy
	    respond_to do |format|
	      format.html { redirect_to root_path, notice: 'Đã xóa câu hỏi.' }
	      format.json { head :no_content }
	    end
	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @qbank = Qbank.find(params[:id])
    end

    def approval
      if !current_user.role
        @qbank.update(accept: 0)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qbank_params
    	if current_user.role
      		params.require(:qbank).permit(:question, :option1, :option2, :option3, :option4, :option_match,
      			:answer, :image, :mp3, :category_id, :subject_id, :user_id, :accept)
      elsif @qbank.nil?
      		params.require(:qbank).permit(:question, :option1, :option2, :option3, :option4, :option_match,
      			:answer, :image, :mp3, :category_id, :subject_id, :user_id)
      else
          params.require(:qbank).permit(:question, :option1, :option2, :option3, :option4, :option_match,
            :answer, :image, :mp3, :category_id, :subject_id)
      	end
    end
end
