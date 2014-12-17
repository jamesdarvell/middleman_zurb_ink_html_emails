BUTTON_STYLES = %w{button small-button tiny-button medium-button large-button}

def ink_button(options = {}, &block)
  options[:href] ||= '#'

  options[:classes] ||= []
  options[:classes] << correct_button_class(options)

  return_ink_markup('button', options, &block)
end

def correct_button_class(options)
  # if there is a correct button class, add nothing
  return nil if (options[:classes] & BUTTON_STYLES).size > 0

  options[:size] ? "#{options[:size]}-button" : "button"
end