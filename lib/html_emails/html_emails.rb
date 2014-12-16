require_relative 'ink_base_module'

class HtmlEmails < Middleman::Extension
  extend InkBaseModule

  def initialize(app, options_hash={}, &block)
    super

    app.after_render do |content, path, locs, template_class|
      content = HtmlEmails.prepare_final_page(content) if HtmlEmails.is_top_level_render?(path)
      content
    end
  end

  class << self
    def prepare_final_page(content)
      content = apply_last_wrapper_class(content)
      clean_xhtml(content)
    end

    def apply_last_wrapper_class(content)
      html_doc = Nokogiri::HTML(content)
      html_doc.css('.row td.wrapper:last-of-type').each do |w|
        w['class'] = (w['class'].split << 'last').join(' ') unless w['class'].include? 'last'
      end

      html_doc.to_xhtml
    end

    def clean_xhtml(content)
      content = content.sub('<![CDATA[', '').sub(']]>', '')
      # this lovely hack was made necessary by a libxml2 bug

      strip_lines(content)
    end

    def strip_lines(content)
      content.split("\n").inject('') {|str, line| str + line.strip + "\n"}
    end

    def is_top_level_render?(path)
      path.include? 'layout.haml'
    end
  end

  helpers do
    require_relative 'helpers/ink_css_helpers'
    require_relative 'helpers/ink_basic_helpers'
    require_relative 'helpers/ink_content_helpers'
    require_relative 'helpers/ink_grid_helpers'
  end
end

::Middleman::Extensions.register(:html_emails, HtmlEmails)