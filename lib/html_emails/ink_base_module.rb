module InkBaseModule
  SIZE_WRONG = 'Size must be an integer between 1 and 12 (or a number in the same range written as a word)'
  SIZE_RANGE = (1..12)
  SIZE_RANGE_AS_WORDS = %w{one two three four five six seven eight nine ten eleven twelve}

  def size_valid?(size)
    (SIZE_RANGE === size) || SIZE_RANGE_AS_WORDS.include?(size)
  end

  def size_as_word(size)
    return size unless SIZE_RANGE === size

    return SIZE_RANGE_AS_WORDS[size - 1]
  end
end