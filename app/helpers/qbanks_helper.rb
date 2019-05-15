module QbanksHelper
	def accepted(accept)
		if accept
			"Đã duyệt"
		else
			"Chưa duyệt"
		end
	end

	def hidden(hide_option)
		if hide_option
			"Có"
		else
			"Không"
		end
	end
end
