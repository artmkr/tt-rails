module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true
    }
    
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def nav_link(text, path)
    options = current_page?(path) ? { class: "active" } : {}
    content_tag(:li, options) do
      link_to text, path
    end
  end

  def bootstrap_class_for flash_type
    { success: "alert-success",
      error: "alert-error",
      alert: "alert-warning",
      notice: "alert-info"
    } [flash_type.to_sym] || flash_type.to_s
  end
end

