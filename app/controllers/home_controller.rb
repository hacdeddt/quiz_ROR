class HomeController < ApplicationController
	skip_before_action :authenticate_user!
	def index
		@subjects = Subject.where("is_delete = 0")
		@categories = Category.where("is_delete = 0")
		category = params[:category_id]
		subject = params[:subject_id]
		name = params[:name]
		value = Test.filter_test(category, subject, name)
		if value == 1
			redirect_to root_path, alert: "Phải chọn đồng thời cả lớp và môn học." 
		else
			@tests = value.paginate(:page => params[:page], :per_page => 18)
		end

	end
end
