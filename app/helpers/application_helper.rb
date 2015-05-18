module ApplicationHelper

  def full_title page_title
    base_title

    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def base_title
    'Playground'
  end

  def data_format data
    data.nil? ? 'N/A' : data.to_i
  end
end
