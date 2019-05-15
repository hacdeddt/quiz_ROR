class TestQbankPolicy < ApplicationPolicy
  attr_reader :current_user, :test_qbank 

  def initialize(current_user, test_qbank)
    @current_user = current_user
    @test_qbank = test_qbank
  end

  def destroy?
  	return true if (@current_user.role || @current_user.id == @test_qbank.test.user.id)
  end
end