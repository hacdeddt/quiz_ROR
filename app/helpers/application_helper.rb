module ApplicationHelper
	def maketitle(ptitle="")
		ptitle + " | Quiz"
	end

	def original_url
  		request.original_fullpath #get url
  	end

  	def gender_user(gender)
  		if gender == "male"
  			"Nam"
  		else
  			"Nữ"
  		end
  	end
end
