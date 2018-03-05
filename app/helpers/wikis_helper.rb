module WikisHelper
  def excerpt(body)
    if body.nil?
      "Cannot load text"
    else
      body.split(' ').first(15).join(' ').concat("...")
    end
  end

  def author_name(wiki)
    if wiki != nil && wiki.user != nil
      wiki.user.name
    else
      "Anonymous"
    end
  end
end
