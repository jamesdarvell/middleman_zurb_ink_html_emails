class HtmlEmails < Middleman::Extension

  def initialize(app, options_hash={}, &block)
    super

    app.after_render do |content, path, locs, template_class|
      content = HtmlEmails.apply_last_wrapper_class(content) if HtmlEmails.is_top_level_render?(path)
      content
    end
  end

  class << self
    def apply_last_wrapper_class(content)
      html_doc = Nokogiri::HTML(content)
      html_doc.css('.row td.wrapper:last-of-type').each do |w|
        w['class'] = (w['class'].split << 'last').join(' ') unless w['class'].include? 'last'
      end

      html_doc.to_html
    end

    def is_top_level_render?(path)
      path.include? 'layout.haml'
    end
  end
end

::Middleman::Extensions.register(:html_emails, HtmlEmails)