module ApplicationHelper
  def full_title(page_title)
    if page_title.blank?
      Const::BASE_TITLE
    else
      "#{page_title} - #{Const::BASE_TITLE}"
    end
  end
end
