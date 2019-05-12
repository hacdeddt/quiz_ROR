require 'digest'

class Qbank < ApplicationRecord
	belongs_to :category
	belongs_to :user
	belongs_to :subject
	has_one_attached :mp3

	before_validation :convert_md5

	def convert_md5
		question = self.question.capitalize
		self.md5_question = Digest::MD5.hexdigest(question)
	end

	# Doi ten bien
	HUMANIZED_ATTRIBUTES = {
	    :question => "Câu hỏi",
	    :optionA => "Tùy chọn A",
	    :optionB => "Tùy chọn B",
	    :optionC => "Tùy chọn C",
	    :optionD => "Tùy chọn D",
	    :option_match => "Tùy chọn đúng",
	    :answer => "Đáp án chi tiết",
	    :md5_question => "Câu hỏi",
	    :mp3 => "File âm thanh"
	  }

	def self.human_attribute_name(attr, options = {})
	  HUMANIZED_ATTRIBUTES[attr.to_sym] || super
	end

	##Validation
	 validates :md5_question, uniqueness: {message: "đã tồn tại"}
	 validates :question, presence: {message: "không được để trống"}
	 validates :optionA, presence: {message: "không được để trống"}
	 validates :optionB, presence: {message: "không được để trống"}
	 validates :optionC, presence: {message: "không được để trống"}
	 validates :optionD, presence: {message: "không được để trống"}
	 validates :option_match, presence: {message: "chưa được chọn"}
  	 validates :mp3, size: { less_than: 1.megabytes , message: 'phải nhỏ hơn 2MB' },
  	 content_type: { in: [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 
  			'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ], 
  			message: 'đây không phải là một file âm thanh.' }

	 validate :check_url

    def check_url
      if question.match(/((https|http|)?:\/\/(?:w{1,3}.)?[^\s]*?(?:\.[a-z]+)+)/)
        errors.add :question, "không được chứa url."
      end
    end

    def self.import(file, category_id, subject_id, of_me)
    	d = 1
    	spreadsheet = open_spreadsheet(file)
    	if !spreadsheet #Nếu không phải các file excel thì không cho tải lên
    		d = -1
    	else
	    	header = spreadsheet.row(1)
	    	header_model = Qbank.column_names
	    # Kiểm tra nếu file csv lấy vào ko khớp với model được chọn
		    if !(header - header_model).empty?
		    	d = 0
		    else	
		    	ActiveRecord::Base.transaction do
			    	(2..spreadsheet.last_row).each do |i|
			    		if d <= 10 #nếu lớn hơn 10 bản ghi đều tồn tại thì dừng ngay vì sợ tấn công DoS
				    		row = Hash[[header, spreadsheet.row(i)].transpose]
				    		qbank = find_by_id(row["id"]) || new
				    		qbank.attributes = row.to_hash.slice(*row.to_hash.keys)
				    		qbank.category_id = category_id
				    		qbank.subject_id = subject_id
				    		qbank.of_me = of_me
				    		if qbank.valid?
				    			qbank.save!
				    		else
				    			d +=1
				    		end
				    	else
				    		break
				    	end
			    	end
			    end
			end
		end
	    return d
    end

    def self.open_spreadsheet(file)
    	case File.extname(file.original_filename)
	    	when ".csv" then Roo::CSV.new(file.path)
	    	when ".xls" then Roo::Excel.new(file.path)
	    	when ".xlsx" then Roo::Excelx.new(file.path)
	    	else return false
    	end
    end

    def self.search_fulltext(question)
    	where("MATCH (question) AGAINST (?) and accept = 1 and is_delete = 0",question)
    end
end
