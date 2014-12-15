require_relative 'ink_base_module'

class HtmlEmails < Middleman::Extension
  extend InkBaseModule

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

      html_doc.to_xhtml
    end

    def is_top_level_render?(path)
      path.include? 'layout.haml'
    end
  end

  helpers do
    require_relative 'helpers/ink_basic_helpers'
    require_relative 'helpers/ink_content_helpers'
    require_relative 'helpers/ink_grid_helpers'
  end
end

::Middleman::Extensions.register(:html_emails, HtmlEmails)