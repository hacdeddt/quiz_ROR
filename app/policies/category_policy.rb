class CategoryPolicy < ApplicationPolicy
  attr_reader :current_user, :category 

  def initialize(current_user, category)
    @current_user = current_user
    @category = category
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

  def delete?
    return true if @current_user.role
  end
end