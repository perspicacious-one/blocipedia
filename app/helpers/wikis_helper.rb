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

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer)

    markdown.render(text).html_safe
  end
end
