class TestsController < ApplicationController
	before_action :set_test, only: [:edit, :update, :test_params, :destroy, :show, :export_pdf, :details]

  def index
  	@tests = Test.paginate(:page => params[:page], :per_page => 20).order('created_at asc')
    authorize @tests
  end

  def show
    Test.update_view(@test)
  end

  def new
  	@test = Test.new
  	@subjects = Subject.all
  	@categories = Category.all
  end

  def create
  	@subjects = Subject.all
  	@categories = Category.all
    @test = Test.new(test_params)
    respond_to do |format|
      if @test.save && verify_recaptcha(model: @test)
        format.html { redirect_to user_test_test_qbanks_path(current_user, @test), notice: 'Thêm đề thi thành công. Mời bạn chọn câu hỏi trong đề thi' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @test
  	@subjects = Subject.all
  	@categories = Category.all
  end

  def update
    authorize @test
  	@subjects = Subject.all
  	@categories = Category.all
    respond_to do |format|
      if @test.update(test_params) && verify_recaptcha(model: @test)
        format.html { redirect_to user_test_test_qbanks_path(current_user, @test), notice: 'Cập nhật đề thi thành công. Tiếp theo là chỉnh sửa câu hỏi' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @test
  	@test.destroy
  	respond_to do |format|
  		format.js {flash.now[:notice] = "Đã xóa đề thi"}
  	end
  end

  def export_pdf
    respond_to do |format|
      format.html
      format.pdf do
        render template: "tests/examine_export.pdf.erb",
        pdf: "#{@test.name}_" + Time.now.strftime('%v %H:%M:%S').to_s,
        encoding: "UTF-8", layout: 'pdf.html.erb', disposition: 'attachment',
        margin:  { top: 15, bottom: 20 }, 
        :footer => { :left => "#{request.domain}", :right => 'Trang [page]/[topage]' }
      end
    end
  end

  def details

  end

  private
    def set_test
      @test = Test.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
    	if @test.nil?
      	  params.require(:test).permit(:name, :description, :full_score, :duration, :category_id, :subject_id, :user_id)
      	else
          params.require(:test).permit(:name, :description, :full_score, :duration, :category_id, :subject_id)
      	end
    end
end
