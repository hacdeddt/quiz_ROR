class Result < ApplicationRecord
	belongs_to :test
	belongs_to :user
	has_many :answers
end
