class AnswersController < ApplicationController
  def show
    @answer = Answer.find(params[:id])
    authorize @answer
  end

  # POST /answers
  # POST /answers.json
  def create
    @qbank_id = ActiveRecord::Base.sanitize_sql(params[:qbank_id])
    @q_option = ActiveRecord::Base.sanitize_sql(params[:q_option])
    Answer.calculate(params[:test_id], @qbank_id, @q_option, current_user.id, params[:result_id])
      respond_to do |format|
          format.html { 
            redirect_to user_test_results_details_path(current_user.id, params[:test_id], params[:result_id]), 
            notice: 'Đã có kết quả.' 
          }
          format.json { render :show, status: :created, location: @answer }
      end
  end
end
