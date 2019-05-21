class QuizDeletedMailer < ApplicationMailer
	def notify_delete_quiz(qbank)
		@qbank = qbank
		@user = @qbank.user
		mail(to: @user.email, subject: "Câu hỏi '#{@qbank.question}' của bạn đã bị xóa.")
	end
end
