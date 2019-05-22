class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: [:edit, :update, :show, :destroy, :banned, :unbanned]

	def index
		num_day = params[:days]
		if num_day.blank?
			@users = User.select("id,fullName, image, year_birthday, gender, address, created_at, banned").where("id != ?",current_user.id).paginate(:page => params[:page], :per_page => 10).order('created_at desc')
		else
			@users = User.select("id,fullName, image, year_birthday, gender, address, created_at, banned").where("id != ? and created_at >= ?",current_user.id, num_day.to_i.days.ago).paginate(:page => params[:page], :per_page => 10).order('created_at desc')
		end	
		authorize @users
	end

	def banned
		if current_user.role
			@user.update(banned: 1)
			respond_to do |format|
				format.js {flash.now[:notice] = "Đã cấm người dùng."}
			end
		end
	end

	def unbanned
		if current_user.role
			@user.update(banned: 0)
			respond_to do |format|
				format.js {flash.now[:notice] = "Đã bỏ cấm người dùng."}
			end
		end
	end

	def edit
		authorize @user
	end

	def show
		authorize @user
		@results = @user.results.includes(:test).where("is_delete = 0").paginate(:page => params[:page], :per_page => 10).order('created_at desc')
		@tests = @user.tests.where("is_delete = 0").paginate(:page => params[:page], :per_page => 10).order('created_at desc')
		@all_tests = @user.tests.offset(10).where("is_delete = 0").order('created_at desc')
	end

	def update
		authorize @user
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to user_path, notice: 'Thông tin cá nhân của bạn đã được cập nhật thành công!' }
				format.json { render :show, status: :ok, location: @user }
			else
				format.html { render :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		authorize @user
		@user.destroy
		respond_to do |format|
			format.js { flash.now[:notice] = "Xóa người dùng thành công"}
		end
	end

	private

	def user_params
		if current_user.role
			params.require(:user).permit(:fullName, :gender, :year_birthday, :address, :image, :role)
		else
			params.require(:user).permit(:fullName, :gender, :year_birthday, :address, :image)
		end
	end

	def set_user
      begin
        @user = User.find(params[:id])
      rescue
        redirect_to root_url
      end
    end
end
