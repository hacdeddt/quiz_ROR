class UserPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def edit?
  	return true if (user.role == true || @current_user.id == user.id) 
  	#@current_user là user mà được sửa ở URL (lấy theo id của user), còn user là tài khoản của người dùng đang đăng nhập vào hệ thống
  	# muốn debug thì sử dụng lệnh bingding.pry
  end

  def update?
  	return true if (user.role == true || @current_user.id == user.id)
  end

  def show?
  	return true if user.present?
  end
end