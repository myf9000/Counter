module ApplicationHelper
	def set_title_of_page(page_title="")
		add = "Count text"
		if page_title.empty?
			page_title = add
		else
			page_title = add+": "+page_title
		end
	end
end
