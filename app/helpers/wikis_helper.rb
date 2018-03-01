module WikisHelper
  def excerpt(body)
    if body.nil?
      "Cannot load text"
    else
      body.split(' ').first(15).join(' ').concat("...")
    end
  end
end
