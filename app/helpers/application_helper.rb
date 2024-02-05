module ApplicationHelper

  def format_address(address)
    "#{address['name']}, #{address['state']}, #{address['country']}"
  end
end
