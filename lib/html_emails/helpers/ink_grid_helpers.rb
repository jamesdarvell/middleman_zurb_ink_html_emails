def ink_container(options = {}, &block)
  return_ink_markup('container', options, &block)
end

def ink_row(options = {}, &block)
  return_ink_markup('row', options, &block)
end

def ink_column(size, options = {}, &block)
  throw HtmlEmails.SIZE_WRONG unless HtmlEmails.size_valid?(size)

  options[:size] = HtmlEmails.size_as_word(size)
  options[:last] ||= false

  return_ink_markup('column', options, &block)
end

def ink_full_width_row(options = {}, &block)
  return_ink_markup('full_width_row', options, &block)
end

def ink_sub_column(size, options = {}, &block)
  throw HtmlEmails.SIZE_WRONG unless HtmlEmails.size_valid?(size)

  options[:size] = HtmlEmails.size_as_word(size)
  options[:last] ||= false

  return_ink_markup('sub_column', options, &block)
end

def ink_block_grid(size, options = {}, &block)
  throw HtmlEmails.SIZE_WRONG unless HtmlEmails.size_valid?(size)

  options[:size] = HtmlEmails.size_as_word(size)

  return_ink_markup('block_grid', options, &block)

end

def ink_block_grid_cell(options = {}, &block)
  return_ink_markup('block_grid_cell', options, &block)
end