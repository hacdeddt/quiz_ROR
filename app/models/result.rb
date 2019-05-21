class Result < ApplicationRecord
	belongs_to :test, :counter_cache => true
	belongs_to :user
	has_many :answers, dependent: :delete_all
end
