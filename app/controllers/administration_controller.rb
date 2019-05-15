class AdministrationController < ApplicationController
  def index
  	@users = User.where("created_at >= ?",1.week.ago).limit(10).order("created_at DESC")
  end

  def accept_qbank
  	@qbanks = Qbank.includes(mp3_attachment: :blob).where("accept = 0 and is_delete = 0").paginate(:page => params[:page], :per_page => 20)
  end

  def qbank_deleted
  	@qbanks = Qbank.includes(mp3_attachment: :blob).where("is_delete = 1").paginate(:page => params[:page], :per_page => 20)
  end
end
