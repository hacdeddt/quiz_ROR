class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :delete]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.where("is_delete = 0")
    authorize @categories
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    authorize @category
  end

  # GET /categories/new
  def new
    @category = Category.new
    authorize @category
  end

  # GET /categories/1/edit
  def edit
    authorize @category
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    authorize @category
    respond_to do |format|
      if @category.save
        format.js {flash.now[:notice] = "Thêm lớp thành công."}
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    authorize @category
    respond_to do |format|
      if @category.update(category_params)
        format.js { flash.now[:notice] = "Cập nhật lớp thành công."}
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    authorize @category
    @category.update(is_delete: 1)
    respond_to do |format|
      format.js {flash.now[:notice] = "Đã xóa lớp."}
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    authorize @category
    @category.destroy
    respond_to do |format|
      format.js { flash.now[:notice] = "Xóa lớp thành công."}
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
