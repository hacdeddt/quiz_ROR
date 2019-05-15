class Category < ApplicationRecord
	has_many :qbanks
	has_many :tests
end
