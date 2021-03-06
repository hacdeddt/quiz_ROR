class AdministrationController < ApplicationController
  def index
    authorize current_user, :admin?
  	@users = User.where("created_at >= ?",1.week.ago).limit(10).order("created_at DESC")
  	@tests = Test.includes(:user).where("created_at >= ?",1.week.ago).order("created_at DESC")
  end

  def accept_qbank
    authorize current_user, :admin?
  	@qbanks = Qbank.includes(mp3_attachment: :blob).where("accept = 0 and is_delete = 0").paginate(:page => params[:page], :per_page => 20)
  end

  def qbank_deleted
    authorize current_user, :admin?
  	@qbanks = Qbank.includes(mp3_attachment: :blob).where("is_delete = 1").paginate(:page => params[:page], :per_page => 20)
  end
end