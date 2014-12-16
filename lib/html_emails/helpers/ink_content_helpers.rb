def ink_boilerplate(&block)
  return_ink_markup('boilerplate', {}, &block)
end

def ink_content(types, options = {}, &block)
  options[:content_types] = types
  return_ink_markup('content', options, &block)
end

def ink_panel(options = {}, &block)
  ink_content(['panel'], options, &block)
end

def ink_center(options = {}, &block)
  ink_content(['center'], options, &block)
end