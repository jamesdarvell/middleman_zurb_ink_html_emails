def ink_image(options)
  check_options_valid(options)
  raise 'Image must have a src attribute' unless options[:src]

  return_ink_markup('image', options) {''} # there is no block for an image
end