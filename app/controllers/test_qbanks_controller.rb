class TestQbanksController < ApplicationController
  before_action :set_test_qbank, only: [:destroy]

  # GET /test_qbanks
  # GET /test_qbanks.json
  def index
    @tests = Test.find(params[:test_id])
    authorize @tests, :add_question?
    @subjects = Subject.where("is_delete = 0")
    @categories = Category.where("is_delete = 0")
    category_id = params[:category_id]
    subject_id = params[:subject_id]
    user_id = params[:of_me]
    name = params[:name]
    
    eligible = "accept = 1 and is_delete = 0"
    
    if category_id.blank? && subject_id.blank? && user_id.nil? && name.blank?
      @qbanks = Test.find(params[:test_id]).qbanks.includes([:category, :user, :subject]).paginate(:page => params[:page], :per_page => 20).order('created_at asc')
      if !@qbanks.present? # cả 4 cái đều trống
        @qbanks = Qbank.includes([:category, :user, :subject]).where("#{eligible}").paginate(:page => params[:page], :per_page => 20).order('created_at asc')
      end
    elsif !category_id.blank? && !subject_id.blank? && user_id.nil? && name.blank? # 2 cái không trống 1 cái trống và không phải search
      @qbanks = Qbank.includes([:category, :user, :subject]).where("category_id = ? and subject_id = ? and #{eligible}", category_id, subject_id).paginate(:page => params[:page], :per_page => 20).order('created_at asc')
    elsif !category_id.blank? && !subject_id.blank? && !user_id.nil? && name.blank? # cả 3 cái đều không trống và không phải search
      @qbanks = Qbank.includes([:category, :user, :subject]).where("category_id = ? and subject_id = ? and user_id = ? and #{eligible}", category_id, subject_id, current_user.id).paginate(:page => params[:page], :per_page => 20).order('created_at asc')
    elsif category_id.blank? && subject_id.blank? && !user_id.nil? && name.blank? # 2 cái trống 1 cái không trống và không phải search
      @qbanks = Qbank.includes([:category, :user, :subject]).where("user_id = ? and #{eligible}", current_user.id).paginate(:page => params[:page], :per_page => 20).order('created_at asc')
    elsif !name.blank? #là search
      @qbanks = Qbank.includes([:category, :user, :subject]).search_fulltext(name).paginate(:page => params[:page], :per_page => 20).order('created_at asc')
    else
      redirect_to user_qbanks_path(current_user), alert: "Phải chọn cả lớp và môn học cùng lúc!"
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /test_qbanks/1
  # GET /test_qbanks/1.json

  # GET /test_qbanks/new
  def new
    @test_qbank = TestQbank.new
  end

  # GET /test_qbanks/1/edit

  # POST /test_qbanks
  # POST /test_qbanks.json
  def create
    @qbank_id = params[:qbank_id]
    @test_id = params[:test_id]
    @test_qbank = TestQbank.new(params.permit(:qbank_id, :test_id))
    respond_to do |format|
      if @test_qbank.save
        @test_bank_id = TestQbank.find_by(qbank_id: params[:qbank_id], test_id: params[:test_id])
        @current_user_id = current_user.id
        format.js {flash.now[:notice] = "Đã thêm câu hỏi vào đề thi."}
      else
        format.html { render :new }
        format.json { render json: @test_qbank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_qbanks/1
  # PATCH/PUT /test_qbanks/1.json

  # DELETE /test_qbanks/1
  # DELETE /test_qbanks/1.json
  def destroy
    authorize @test_qbank
    @qbank_id = @test_qbank.qbank_id
    @test_qbank.destroy
    respond_to do |format|
      format.js {flash.now[:notice] = "Đã xóa câu hỏi ra khỏi đề thi."}
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_qbank
      @test_qbank = TestQbank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_qbank_params
      params.require(:test_qbank).permit(:qbank_id, :test_id)
    end
end
