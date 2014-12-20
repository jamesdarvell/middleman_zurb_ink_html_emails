require_relative 'zurb_ink'
require 'numbers_in_words/duck_punch'

class HtmlEmails < Middleman::Extension
  extend ZurbInk

  def initialize(app, options_hash={}, &block)
    super

    @@image_dimensions = {}

    app.set :partials_dir, partials_path_relative_to_source(app.config)

    app.after_render do |content, path, locs, template_class|
      HtmlEmails.is_top_level_render?(path) ? HtmlEmails.prepare_final_page(content) : content
    end
  end

  class << self
    def prepare_final_page(content)
      content = add_class_to_last_columns(content)
      content = set_attributes_for_ink_images(content)
      content = clean_xhtml(content)
      content = inline_css(content)
      remove_whitespace_between_block_grid_cells(content)
    end

    ##
    # The last class is used on the last column to apply correct padding (so gutters are correct).
    # For the "grid" system, this applies to the wrapper td which contains the column.
    # For the sub-column grid, it is applied directly to the "sub-columns" td
    ##
    def add_class_to_last_columns(content)
      html_doc = Nokogiri::HTML(content)
      html_doc.css('.row td.wrapper:last-of-type').each do |w|
        w['class'] = (w['class'].split << 'last').join(' ') unless w['class'].include? 'last'
      end

      html_doc.css('.columns>tr>td.sub-columns:last-of-type').each do |s|
        s['class'] = (s['class'].split << 'last').join(' ') unless s['class'].include? 'last'
      end

      html_doc.to_xhtml
    end

    ##
    # Ink images should have explicit width and height attributes.
    # The width should match the width of the containing column.
    # The height should be scaled down from the original height so that aspect ratio is maintained.
    #
    # This method must:
    #   1: Find the containing column (first column among ancestors) and look up its the pixel width
    #   2: Calculate the scaled height of the image
    #   3: Assign the attributes using the calculated width and height
    #   4: Remove the ink_image html class - this was only included to allow this method to find the img
    #
    ##
    def set_attributes_for_ink_images(content)
      html_doc = Nokogiri::HTML(content)
      html_doc.css('.ink_image').each do |img|

        width = pix_width_of_containing_column(img)
        height = scaled_height_of_image(img[:src], width)

        img[:width] = width
        img[:height] = height
        img[:class] = img[:class].gsub('ink_image', '')
      end

      html_doc.to_xhtml
    end

      ##
      # This method returns the correct width to set on the image.
      # This is the width of the containing column. It is calculated by:
      #  1: Finding the containing column (first column among ancestors)
      #  2: Looking up its the pixel width from the table defined in INK_COLUMN_WIDTHS
      ##
      def pix_width_of_containing_column(img)
        column = img.ancestors('.columns').first
        col_width = (column['class'].split & SIZE_RANGE_AS_WORDS).first.in_numbers

        INK_COLUMN_WIDTHS[col_width]
      end

      ##
      # This method will return the desired height of the image.
      # It is calculated by:
      # 1: Downloading the image
      # 2: Finding the ratio of the original width to the new width
      # 3: Applying this ratio to the original height
      ##
      def scaled_height_of_image(src, width)
        w,h = 0,1

        dimensions = get_image_size(src)
        scale = width.to_f / dimensions[w]

        (dimensions[h] * scale).to_i
      end

      def get_image_size(src)
        binding.pry
        @@image_dimensions[src] ||= FastImage.size(src, :raise_on_failure=>true, :timeout=>5)
      end

    def clean_xhtml(content)
      content = content.gsub(/(\/\*)?(<!\[CDATA\[>?|\]+>)(\*\/)?/ ,'')
      # this lovely hack was made necessary by a libxml2 bug

      strip_lines(content)
    end

    def strip_lines(content)
      content.split("\n").inject('') {|str, line| str + line.strip + "\n"}
    end

    def is_top_level_render?(path)
      path.include? 'layout.haml'
    end

    def inline_css(content)
      premailer = Premailer.new(content, :with_html_string => true)
      content = premailer.to_inline_css

      clean_xhtml(content)
    end

    def remove_whitespace_between_block_grid_cells(content)
      content.gsub("\n<!-- END OF BLOCK-GRID CELL -->\n", '')
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