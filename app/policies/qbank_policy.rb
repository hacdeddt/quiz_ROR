class QbankPolicy < ApplicationPolicy
  attr_reader :user, :current_user 

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def edit?
  	return true if (user.role || @current_user.id == user.id) 
  end

  def update?
  	return true if (user.role || @current_user.id == user.id)
  end

  def delete?
  	return true if (user.role || @current_user.id == user.id)
  end

  def show?
  	return true if (user.role || @current_user.id == user.id)
  end
end