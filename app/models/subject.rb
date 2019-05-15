class Subject < ApplicationRecord
  has_many :qbanks
  has_many :tests
  
	before_validation :transfer_name

	HUMANIZED_ATTRIBUTES = {
    :name => "Tên môn học"
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  validates :name, format: { with: /\A[\p{Word}\s]+\z/, message: "không được để trống và chỉ bao gồm chữ và số" },
  uniqueness: {message: "đã tồn tại"}

	def transfer_name
		self.name.capitalize!
	end
end
