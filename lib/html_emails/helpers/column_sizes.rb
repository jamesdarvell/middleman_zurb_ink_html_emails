module ColumnSizes
  SIZE_WRONG = 'Size must be an integer between 1 and 12 (or a number in the same range written as a word)'
  SIZE_RANGE = (1..12)
  SIZE_RANGE_AS_WORDS = %w{one two three four five six seven eight nine ten eleven twelve}
  INK_COLUMN_WIDTHS = [0, 30, 80, 130, 180, 230, 280, 330, 380, 430, 480, 530, 580]

  def size_valid?(size)
    (ZurbInk::SIZE_RANGE === size) || ZurbInk::SIZE_RANGE_AS_WORDS.include?(size)
  end

  def size_as_word(size)
    return size unless ZurbInk::SIZE_RANGE === size

    return ZurbInk::SIZE_RANGE_AS_WORDS[size - 1]
  end
end