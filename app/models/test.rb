class Test < ApplicationRecord
	belongs_to :category
	belongs_to :user
	belongs_to :subject
	has_many :test_qbanks, dependent: :destroy
	has_many :qbanks, through: :test_qbanks
	has_many :results

	HUMANIZED_ATTRIBUTES = {
	    :name => "Tên đề thi",
	    :description => "Mô tả",
	    :full_score => "Điểm tuyệt đối",
	    :duration => "Thời gian làm bài"
	  }

	def self.human_attribute_name(attr, options = {})
	  HUMANIZED_ATTRIBUTES[attr.to_sym] || super
	end

	validates :name, format: { with: /\A[\p{Word}\d\s+-_,]+\z/, 
		message: "không được để trống và chỉ bao gồm chữ và số"}
	validates :full_score, format: {with: /\A[0-9]+\z/,message: "không được để trống và chỉ bao gồm số" }
	validates :duration, format: {with: /\A[0-9]+\z/,message: "không được để trống và chỉ bao gồm số" }

	def self.update_view(test)
		view = test.views + 1
		test.update(views: view)
	end

end
