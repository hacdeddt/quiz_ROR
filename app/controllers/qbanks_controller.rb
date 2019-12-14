class QbanksController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy, :delete, :qbank_params, :accepted, :recover, :reversion]
  before_action :get_categories_subjects, only: [:index, :new, :create, :edit, :update]
  before_action :get_size_quiz, only: [:accepted, :destroy, :recover]
  before_action :check_admin, only: [:destroy, :accepted, :recover, :reversion]

  def index
    user_id = params[:of_me]
    value = Qbank.filter_qbanks(params[:category_id], params[:subject_id], user_id,
      params[:name], current_user.id)
    message = 'Must choose both class and subject at the same time!'
    return redirect_to user_qbanks_path(current_user), alert: message if value == 1
    @qbanks = value.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    authorize @qbank
  end

  def new
  	@qbank = Qbank.new
  end

  def create
    @qbank = Qbank.new(qbank_params)
    respond_to do |format|
      if @qbank.save && verify_recaptcha(model: @qbank)
        format.html { redirect_to user_qbank_path(current_user, @qbank), 
          notice: 'Your question has been successfully added and is being reviewed.' }
        format.json { render :show, status: :created, location: @qbank }
      else
        format.html { render :new }
        format.json { render json: @qbank.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @qbank
  end

  def update
    authorize @qbank
    if qbank_params['mp3'].present?
      @qbank.mp3.purge.nil?
    end
    respond_to do |format|
      if @qbank.update(qbank_params) && verify_recaptcha(model: @qbank)
        unless current_user.role
          if @qbank.saved_change_to_question? || @qbank.saved_change_to_optionA? || @qbank.saved_change_to_optionB? ||
           @qbank.saved_change_to_optionC? || @qbank.saved_change_to_optionD? || @qbank.saved_change_to_answer?
            @qbank.update(accept: 0)
          end
        end
        format.html { redirect_to user_qbank_path(current_user, @qbank),
          notice: 'Updated question successfully and is being reviewed.' }
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
      format.js { flash.now[:notice] = 'Question deleted.' }
    end
  end

  def reversion # quay lại bản ghi đã được chấp nhận trước đó.
    records_accept = @qbank.versions.where_object(accept: true).includes(:item)
    if records_accept.size > 1
      records_accept[records_accept.size - 2].reify.save
      respond_to do |format|
        format.js { flash.now[:notice] = 'Reversed the question back to the same.' }
      end
    end
  end

  def accepted 
    @qbank.update(accept: 1)
    respond_to do |format|
      format.js { flash.now[:notice] = 'Approved.' }
    end
  end

  def recover
    @qbank.update(is_delete: 0)
    respond_to do |format|
      format.json { render :show, status: :ok, location: @qbank }
      format.js { flash.now[:notice] = 'Restored.' }
    end
  end

  def destroy
    @qbank.mp3.purge
    QuizDeletedMailer.notify_delete_quiz(@qbank).deliver_now
    @qbank.destroy
    respond_to do |format|
      format.html { redirect_to user_qbanks_path(current_user), notice: 'Question deleted.' }
      format.json { head :no_content }
      format.js { flash.now[:notice] = 'Question deleted.'}
    end
  end

  def import
    message = 'Captcha has not been verified'
    return redirect_to user_qbanks_path(current_user), alert: message unless verify_recaptcha(model: @qbank)

    count = Qbank.import(params[:file], params[:category_id], params[:subject_id], current_user.id)
    case count
    when -1
      message = 'Can only import excel file.'
    when 0
      message = 'The fields in the excel file are inconsistent, please review!'
    when 1
      redirect_to user_qbanks_path(current_user), 
      notice: 'Questions have been added and are being reviewed. Thank you!'
    when 11
      message = 'Many questions already exist. So we stopped the question input process. Please check the excel file before continuing.'
    else
      message = 'The excel file with the question already exists. However, questions that do not exist are still uploaded and are being reviewed. Thank you!'
    end
    redirect_to user_qbanks_path(current_user), alert: message
  end

  def download_file_excel_sample
    send_file("#{Rails.root}/public/import_quiz.xlsx")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @qbank = Qbank.find_by(id: params[:id])
    end

    def get_categories_subjects
      @subjects = Subject.where(is_delete: 0)
      @categories = Category.where(is_delete: 0)
    end

    def get_size_quiz
      @qbanks = Qbank.where(accept: 0, is_delete: 0).size
    end

    def check_admin
      return redirect_to root_path unless current_user.role
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qbank_params
    	if current_user.role
      	params.require(:qbank).permit(:question, :optionA, :optionB, :optionC, :optionD, :option_match,
      		:answer, :image, :mp3, :category_id, :subject_id, :user_id, :accept, :hide_option)
      else
        add_params = @qbank.nil? ? :user_id : nil
        params.require(:qbank).permit(:question, :optionA, :optionB, :optionC, :optionD, :option_match,
        	:answer, :image, :mp3, :category_id, :subject_id, add_params, :hide_option)
      end
    end
end
