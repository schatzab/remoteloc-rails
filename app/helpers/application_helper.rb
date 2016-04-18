module ApplicationHelper

	def error_messages_for(object)
		render(partial: 'application/error_messages', locals: {object: object})
	end

	def status_tag(boolean, options={}) # call status tag and pass a boolean and give it options
		options[:true_text] ||= ''
		options[:false_text] ||= ''

		if boolean # will make a span tag and will put in true or false text I've already declared.  Will also give it class true or class false.
			content_tag(:span, options[:true_text], class: 'status true')
		else
			content_tag(:span, options[:false_text], class: 'status false')
		end
	end
end