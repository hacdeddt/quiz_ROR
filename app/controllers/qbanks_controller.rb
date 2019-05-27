class QbanksController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy, :delete, :qbank_params, :accepted, :recover, :reversion]
  def index
    @subjects = Subject.where("is_delete = 0")
    @categories = Category.where("is_delete = 0")
    category_id = params[:category_id]
    subject_id = params[:subject_id]
    user_id = params[:of_me]
    name = params[:name]
    value = Qbank.filter_qbanks(category_id, subject_id, user_id, name, current_user.id)
    if value == 1
      redirect_to user_qbanks_path(current_user), alert: "Phải chọn cả lớp và môn học cùng lúc!"
    else
      @qbanks = value.paginate(:page => params[:page], :per_page => 20)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    authorize @qbank
  end

  def new
  	@qbank = Qbank.new
  	@subjects = Subject.where("is_delete = 0")
    @categories = Category.where("is_delete = 0")
  end

  def create
  	@subjects = Subject.where("is_delete = 0")
    @categories = Category.where("is_delete = 0")
    @qbank = Qbank.new(qbank_params)
    respond_to do |format|
      if @qbank.save && verify_recaptcha(model: @qbank)
        format.html { redirect_to user_qbank_path(current_user, @qbank), notice: 'Câu hỏi của bạn đã được thêm thành công và đang được xét duyệt.' }
        format.json { render :show, status: :created, location: @qbank }
      else
        format.html { render :new }
        format.json { render json: @qbank.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @qbank
    @subjects = Subject.where("is_delete = 0")
    @categories = Category.where("is_delete = 0")
  end

  def update
    authorize @qbank
  	@subjects = Subject.where("is_delete = 0")
    @categories = Category.where("is_delete = 0")
    if qbank_params['mp3'].present?
      @qbank.mp3.purge.nil?
    end
    respond_to do |format|
      if @qbank.update(qbank_params) && verify_recaptcha(model: @qbank)
        if !current_user.role
          if @qbank.saved_change_to_question? || @qbank.saved_change_to_optionA? || @qbank.saved_change_to_optionB? ||
           @qbank.saved_change_to_optionC? || @qbank.saved_change_to_optionD? || @qbank.saved_change_to_answer?
            @qbank.update(accept: 0)
          end
        end
        format.html { redirect_to user_qbank_path(current_user, @qbank), notice: 'Cập nhật câu hỏi thành công và đang được xét duyệt.' }
        format.json { render :show, status: :ok, location: @qbank }
      else
        format.html { render :edit }
        format.json { render json: @qbank.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    authorize @qbank
    @qbank.update(is_delete: 1)
    respond_to do |format|
      format.js {flash.now[:notice] = "Đã xóa câu hỏi."}
    end
  end

  def reversion # quay lại bản ghi đã được chấp nhận trước đó.
    records_accept = @qbank.versions.where_object(accept: true).includes(:item)
    if records_accept.size > 1
      records_accept[records_accept.size - 2].reify.save
      respond_to do |format|
        format.js {flash.now[:notice] = "Đã đảo ngược câu hỏi lại thành như cũ."}
      end
    end
  end

  def accepted
    if current_user.role  
      @qbank.update(accept: 1)
      @qbanks = Qbank.where("accept = 0 and is_delete = 0").size
      respond_to do |format|
        format.js {flash.now[:notice] = "Đã duyệt."}
      end
    end
  end

  def recover
    if current_user.role  
      @qbank.update(is_delete: 0)
      @qbanks = Qbank.where("accept = 0 and is_delete = 0").size
      respond_to do |format|
        format.json { render :show, status: :ok, location: @qbank }
        format.js {flash.now[:notice] = "Đã khôi phục."}
      end
    end
  end

  def destroy
  	if (current_user.role)
      @qbank.mp3.purge
      QuizDeletedMailer.notify_delete_quiz(@qbank).deliver
	    @qbank.destroy
      @qbanks = Qbank.where("accept = 0 and is_delete = 0").size
	    respond_to do |format|
	      format.html { redirect_to user_qbanks_path(current_user), notice: 'Đã xóa câu hỏi.' }
	      format.json { head :no_content }
        format.js { flash.now[:notice] = "Đã xóa câu hỏi"}
	    end
	  end
  end

  def import
    if verify_recaptcha(model: @qbank)
      count = Qbank.import(params[:file], params[:category_id], params[:subject_id], current_user.id)
      if count == -1
        redirect_to user_qbanks_path(current_user), alert: "Chỉ có thể import file excel"
      elsif count == 0
        redirect_to user_qbanks_path(current_user), 
        alert: "Các trường trong file excel là không phù hợp, vui lòng xem lại!"
      elsif count == 1
        redirect_to user_qbanks_path(current_user), 
        notice: "Các câu hỏi đã được thêm và đang được xét duyệt. Cảm ơn bạn!"
      elsif count == 11
        redirect_to user_qbanks_path(current_user), 
        alert: "Có nhiều câu hỏi đã tồn tại. Vì vậy, chúng tôi đã ngừng quá trình nhập câu hỏi. Bạn vui lòng kiểm tra lại file excel trước khi tiếp tục."
      else
        redirect_to user_qbanks_path(current_user), 
        alert: "File excel có câu hỏi đã tồn tại. Tuy nhiên các câu hỏi chưa tồn tại vẫn được tải lên và đang được xét duyệt. Cảm ơn bạn!"
      end
    else
      redirect_to user_qbanks_path(current_user), 
      alert: "Captcha chưa được xác minh"
    end
  end

  def download_file_excel_sample
    send_file("#{Rails.root}/public/import_quiz.xlsx")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @qbank = Qbank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qbank_params
    	if current_user.role
      		params.require(:qbank).permit(:question, :optionA, :optionB, :optionC, :optionD, :option_match,
      			:answer, :image, :mp3, :category_id, :subject_id, :user_id, :accept, :hide_option)
      elsif @qbank.nil?
      		params.require(:qbank).permit(:question, :optionA, :optionB, :optionC, :optionD, :option_match,
      			:answer, :image, :mp3, :category_id, :subject_id, :user_id, :hide_option)
      else
          params.require(:qbank).permit(:question, :optionA, :optionB, :optionC, :optionD, :option_match,
            :answer, :image, :mp3, :category_id, :subject_id, :hide_option)
      	end
    end
end
