class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :destroy, :delete, :result_details]

  # GET /results
  # GET /results.json
  def index
    @results = Result.where("is_delete = 0")
  end

  # GET /results/1
  # GET /results/1.json
  def show
    @test = Test.find(params[:test_id])
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.create(params.permit(:test_id, :user_id))
    Test.reset_counters(params[:test_id], :results)

    respond_to do |format|
      format.html { redirect_to user_test_result_path(current_user.id, params[:test_id], @result) }
      format.json { render :show, status: :created, location: @result }
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    authorize @result
    @result.destroy
    respond_to do |format|
      format.html { redirect_to user_test_results_url(params[:user_id],params[:test_id]), notice: 'Result was successfully destroyed.' }
      format.js {flash.now[:notice] = "Đã xóa kết quả thành công"}
      format.json { head :no_content }
    end
  end

  def delete
    authorize @result
    @result.update(is_delete: 1)
    respond_to do |format|
      format.js {flash.now[:notice] = "Đã xóa kết quả."}
    end
  end

  def result_details
    authorize @result
    @test = Test.find(params[:test_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end
end
