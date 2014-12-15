require_relative 'ink_base_module'

module InkGridHelpers
  include InkBaseModule

  SIZE_WRONG = 'Size must be an integer between 1 and 12 (or a number in the same range written as a word)'
  SIZE_RANGE = (1..12)
  SIZE_RANGE_AS_WORDS = %w{one two three four five six seven eight nine ten eleven twelve}

  def ink_container(options = {}, &block)
    return_ink_markup('container', options, &block)
  end

  def ink_row(options = {}, &block)
    return_ink_markup('row', options, &block)
  end

  def ink_column(size, options = {}, &block)
    throw SIZE_WRONG unless size_valid?(size)

    options[:size] = size_as_word(size)
    options[:last] ||= false

    return_ink_markup('column', options, &block)
  end

  private
  def size_valid?(size)
    (SIZE_RANGE === size) || SIZE_RANGE_AS_WORDS.include?(size)
  end

  def size_as_word(size)
    return size unless SIZE_RANGE === size

    return SIZE_RANGE_AS_WORDS[size - 1]
  end

end
