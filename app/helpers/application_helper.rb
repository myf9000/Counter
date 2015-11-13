module ApplicationHelper
	def set_title_of_page(page_title="")
		add = "Count Your's TxT"
		if page_title.empty?
			page_title = add
		else
			page_title = page_title+ " | " +add
		end
	end
end
