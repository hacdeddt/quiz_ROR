class Answer < ApplicationRecord
	belongs_to :user
	belongs_to :result
	belongs_to :qbank
end
