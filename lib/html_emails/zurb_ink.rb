module ZurbInk
  SIZE_WRONG = 'Size must be an integer between 1 and 12 (or a number in the same range written as a word)'
  SIZE_RANGE = (1..12)
  SIZE_RANGE_AS_WORDS = %w{one two three four five six seven eight nine ten eleven twelve}
  INK_COLUMN_WIDTHS = [0, 30, 80, 130, 180, 230, 280, 330, 380, 430, 480, 530, 580]

  def size_valid?(size)
    (SIZE_RANGE === size) || SIZE_RANGE_AS_WORDS.include?(size)
  end

  def size_as_word(size)
    return size unless SIZE_RANGE === size

    return SIZE_RANGE_AS_WORDS[size - 1]
  end

  # move the registration of zurb specific helper methods into this module in order to seperate concerns
  def self.extended(base)
    base.helpers do
      require_relative 'helpers/ink_css_helpers'
      require_relative 'helpers/ink_basic_helpers'
      require_relative 'helpers/ink_content_helpers'
      require_relative 'helpers/ink_grid_helpers'
      require_relative 'helpers/ink_button_helpers'
      require_relative 'helpers/ink_image_helpers'
    end
  end
end