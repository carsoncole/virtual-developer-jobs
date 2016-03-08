module ApplicationHelper
  def canonical
    # replace http with https once ssl is added
    @canonical = "#{request.url.split('?').first}".gsub("http:", "http:")
  end
end
