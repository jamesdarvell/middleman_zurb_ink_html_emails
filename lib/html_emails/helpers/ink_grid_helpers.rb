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
