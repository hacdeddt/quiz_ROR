class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: [:edit, :update, :show, :update_image]

	def edit
		authorize @user
		authorize current_user
	end

	def show
		authorize @user
	end

	def update
		authorize @user
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to user_path, notice: 'User was successfully updated.' }
				format.json { render :show, status: :ok, location: @user }
			else
				format.html { render :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end

		end
	end

	private

	def user_params
			params.require(:user).permit(:fullName, :gender, :year_birthday, :address, :image)
	end

	def set_user
      begin
        @user = User.find(params[:id])
      rescue
        redirect_to root_url
      end
    end
end
