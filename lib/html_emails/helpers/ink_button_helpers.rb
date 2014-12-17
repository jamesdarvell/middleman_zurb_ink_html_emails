def ink_button(options = {}, &block)
  options[:href] ||= '#'
  return_ink_markup('button', options, &block)
end