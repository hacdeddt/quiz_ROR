class UserPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def edit?
  	return true if user.present? && user.admin? || (@current_user.id == user.id)
  end

  def update?
  	return true if user.present? && user.admin? || (@current_user.id == user.id)
  end

  def show?
  	return true if user.present?
  end
end