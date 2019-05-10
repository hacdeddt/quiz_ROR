require 'digest'

class Qbank < ApplicationRecord
	belongs_to :category
	belongs_to :user
	belongs_to :subject

	before_validation :convert_md5

	def convert_md5
		question = self.question.capitalize
		self.md5_question = Digest::MD5.hexdigest(question)
	end

	# Doi ten bien
	HUMANIZED_ATTRIBUTES = {
	    :question => "Câu hỏi",
	    :option1 => "Tùy chọn 1",
	    :option2 => "Tùy chọn 2",
	    :option3 => "Tùy chọn 3",
	    :option4 => "Tùy chọn 4",
	    :option_match => "Tùy chọn đúng",
	    :answer => "Đáp án chi tiết",
	    :md5_question => "Câu hỏi",
	  }

	def self.human_attribute_name(attr, options = {})
	  HUMANIZED_ATTRIBUTES[attr.to_sym] || super
	end

	##Validation
	 validates :md5_question, uniqueness: {message: "đã tồn tại"}
	 validates :question, presence: {message: "không được để trống"}
	 validates :option1, presence: {message: "không được để trống"}
	 validates :option2, presence: {message: "không được để trống"}
	 validates :option3, presence: {message: "không được để trống"}
	 validates :option4, presence: {message: "không được để trống"}
	 validates :option_match, presence: {message: "chưa được chọn"}

	 validate :check_url

    def check_url
      if question.match(/((https|http|)?:\/\/(?:w{1,3}.)?[^\s]*?(?:\.[a-z]+)+)/)
        errors.add :question, "không được chứa url."
      end
    end
end
