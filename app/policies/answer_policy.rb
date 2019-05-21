class AnswerPolicy < ApplicationPolicy
  attr_reader :current_user, :answer 

  def initialize(current_user, answer)
    @current_user = current_user
    @answer = answer
  end

  def show?
  	return true if (@current_user.role || @current_user.id == @answer.user.id)
  end
end