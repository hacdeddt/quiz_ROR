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

 def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
