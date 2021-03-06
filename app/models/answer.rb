class Answer < ApplicationRecord
	belongs_to :user
	belongs_to :result
	belongs_to :qbank

	def self.calculate(test_id, qbank_id, q_option, user_id, result_id)
		noq = Test.find(test_id).qbanks.where("accept = 1").size
		score = (Test.find(test_id).full_score.to_f / noq).round(2)
		number_answer_correct = 0
		columns = [:user_id, :qbank_id, :result_id, :q_option, :q_score]
		values = []
	    ActiveRecord::Base.transaction do
	      for i in 0...noq.to_i do
	      	if (!q_option.nil? && q_option["#{i}".to_sym].present?)
		        if (Qbank.find(qbank_id["#{i}".to_sym]).option_match != q_option["#{i}".to_sym])
		          q_score = 0
		        else
		          q_score = score
		          number_answer_correct +=1
		        end
		        values << [user_id, qbank_id["#{i}".to_sym], result_id, q_option["#{i}".to_sym], q_score]
		    end
	      end
	      	Answer.import columns, values, validate: false
		    @result = Result.find(result_id)
		    @result.update(total_score: @result.answers.sum(:q_score), num_an_correct: number_answer_correct, noq: noq)
		    @result.update(total_time: ((@result.updated_at - @result.created_at) / 1.minutes))
	    end
	end
end
