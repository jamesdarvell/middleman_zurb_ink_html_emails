module InkGridHelpers
  include ::InkBasicHelpers

  def ink_container(options = {}, &block)
    check_options_valid(options)
    return_ink_markup('container', options, &block)
  end

  def ink_row(options = {}, &block)
    check_options_valid(options)
    return_ink_markup('row', options, &block)
  end

  def ink_column(size, options = {}, &block)
    throw HtmlEmails.SIZE_WRONG unless HtmlEmails.size_valid?(size)
    check_options_valid(options)

    options[:size] = HtmlEmails.size_as_word(size)
    options[:last] ||= false

    return_ink_markup('column', options, &block)
  end

  def ink_full_width_row(options = {}, &block)
    check_options_valid(options)
    return_ink_markup('full_width_row', options, &block)
  end

  def ink_section(options = {}, &block)
    check_options_valid(options)
    return_ink_markup('section', options, &block)
  end

  def ink_wrapper(options = {}, &block)
    check_options_valid(options)

    options[:last] ||= false

    return_ink_markup('wrapper', options, &block)
  end

  def ink_stacked_column(size, options = {}, &block)
    throw HtmlEmails.SIZE_WRONG unless HtmlEmails.size_valid?(size)
    check_options_valid(options)

    options[:size] = HtmlEmails.size_as_word(size)

    return_ink_markup('stacked_column', options, &block)
  end

  def ink_sub_column(size, options = {}, &block)
    throw HtmlEmails.SIZE_WRONG unless HtmlEmails.size_valid?(size)
    check_options_valid(options)

    options[:size] = HtmlEmails.size_as_word(size)
    options[:last] ||= false

    return_ink_markup('sub_column', options, &block)
  end

  def ink_block_grid(size, options = {}, &block)
    throw HtmlEmails.SIZE_WRONG unless HtmlEmails.size_valid?(size)
    check_options_valid(options)

    options[:size] = HtmlEmails.size_as_word(size)

    return_ink_markup('block_grid', options, &block)

  end

  def ink_block_grid_cell(options = {}, &block)
    check_options_valid(options)
    return_ink_markup('block_grid_cell', options, &block)
  end
end