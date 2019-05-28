class ResultPolicy < ApplicationPolicy
  attr_reader :current_user, :result 

  def initialize(current_user, result)
    @current_user = current_user
    @result = result
  end

  def destroy?
  	return true if @current_user.role
  end

  def delete?
    return true if (@current_user.role || @current_user.id == @result.user.id)
  end

  def result_details?
    return true if (@current_user.role || @current_user.id == @result.user.id)
  end

  def index?
    return true if @current_user.role
  end
end