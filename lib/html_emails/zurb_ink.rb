require_relative 'helpers/column_sizes'
require_relative 'helpers/ink_basic_helpers'
require_relative 'helpers/ink_css_helpers'
require_relative 'helpers/ink_content_helpers'
require_relative 'helpers/ink_grid_helpers'
require_relative 'helpers/ink_button_helpers'
require_relative 'helpers/ink_image_helpers'

module ZurbInk
  include ColumnSizes

  # zurb ink specific helpers are defined in these specific modules. They are added to the HtmlEmail extension when it
  # extends the ZurbInk module.
  def self.extended(base)
    base.helpers(InkButtonHelpers, InkButtonHelpers, InkContentHelpers, InkCssHelpers, InkGridHelpers, InkImageHelpers)
  end
end