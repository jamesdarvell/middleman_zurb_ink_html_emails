require_relative 'zurb_ink'

class HtmlEmails < Middleman::Extension
  extend ZurbInk

  def initialize(app, options_hash={}, &block)
    super

    app.set :partials_dir, partials_path_relative_to_source(app.config)

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


  private
  def partials_path_relative_to_source(config)
    partials_path = Pathname.new (get_partials_path)
    source_path = Pathname.new (config[:source])

    partials_path.relative_path_from(source_path).to_s
  end

  def get_partials_path
    File.join(get_path_to_this_extension, 'partials')
  end

  def get_path_to_this_extension
    File.dirname(__FILE__).split('/')[-2..-1].join('/')
  end
end

::Middleman::Extensions.register(:html_emails, HtmlEmails)