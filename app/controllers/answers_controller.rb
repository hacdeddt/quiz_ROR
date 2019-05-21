class AnswersController < ApplicationController
  def show
    @answer = Answer.find(params[:id])
    authorize @answer
  end

  # POST /answers
  # POST /answers.json
  def create
    Answer.calculate(params[:test_id], params[:noq], params[:qbank_id], params[:q_option], params[:user_id], params[:result_id])
      respond_to do |format|
          format.html { 
            redirect_to user_test_results_details_path(current_user.id, params[:test_id], params[:result_id]), 
            notice: 'Đã có kết quả.' 
          }
          format.json { render :show, status: :created, location: @answer }
      end
  end
end
