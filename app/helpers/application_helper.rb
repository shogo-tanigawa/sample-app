module ApplicationHelper

  def full_title(page_name = "")
    base_title = "Task App"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
  
  require "uri"
  
  def description_url_to_link(description)

    URI.extract(description, ['http','https']).uniq.each do |url|
      sub_description = ""
      sub_description << "<a href=" << url << " target=\"_blank\">" << url << "</a>"

      description.gsub!(url, sub_description)
    end

    return description
  end
end