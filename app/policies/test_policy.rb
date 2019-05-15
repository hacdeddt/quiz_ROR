class TestPolicy < ApplicationPolicy
  attr_reader :current_user, :test 

  def initialize(current_user, test)
    @current_user = current_user
    @test = test
  end

  def edit?
  	return true if (@current_user.role || @current_user.id == @test.user.id)
  end

  def update?
  	return true if (@current_user.role || @current_user.id == @test.user.id)
  end

  def destroy?
  	return true if (@current_user.role || @current_user.id == @test.user.id)
  end

  def show?
    return true if (@current_user.role || @current_user.id == @test.user.id)
  end

  def index?
    return true if (@current_user.role || @current_user.id == @test.user.id)
  end
end