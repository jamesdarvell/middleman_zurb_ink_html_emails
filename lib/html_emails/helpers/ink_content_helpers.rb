def ink_boilerplate(&block)
  return_ink_markup('boilerplate', {}, &block)
end

def ink_panel(options = {}, &block)
  return_ink_markup('panel', options, &block)
end