class SubjectPolicy < ApplicationPolicy
  attr_reader :current_user, :subject 

  def initialize(current_user, subject)
    @current_user = current_user
    @subject = subject
  end

  def edit?
  	return true if @current_user.role
  end

  def update?
  	return true if @current_user.role
  end

  def index?
  	return true if @current_user.role
  end

  def show?
    return true if @current_user.role
  end

  def destroy?
    return true if @current_user.role
  end

  def new?
    return true if @current_user.role
  end

  def create?
    return true if @current_user.role
  end
end