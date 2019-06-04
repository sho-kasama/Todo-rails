module ApplicationHelper
  def full_ttl(page_ttl = '')
    base_ttl = 'TodoRails'
    page_ttl.blank? ? base_ttl : page_ttl + ' | ' + base_ttl
  end 
end
