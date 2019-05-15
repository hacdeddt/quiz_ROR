class QbankPolicy < ApplicationPolicy
  attr_reader :current_user, :qbank 

  def initialize(current_user, qbank)
    @current_user = current_user
    @qbank = qbank
  end

  def edit?
  	return true if (@current_user.role || @current_user.id == @qbank.user.id)
  end

  def update?
  	return true if (@current_user.role || @current_user.id == @qbank.user.id)
  end

  def delete?
  	return true if (@current_user.role || @current_user.id == @qbank.user.id)
  end

  def show?
  	return true if (@current_user.role || @current_user.id == @qbank.user.id)
  end
end