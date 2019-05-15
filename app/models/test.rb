class Test < ApplicationRecord
	belongs_to :category
	belongs_to :user
	belongs_to :subject
	has_many :test_qbanks, dependent: :destroy
	has_many :qbanks, through: :test_qbanks
end
