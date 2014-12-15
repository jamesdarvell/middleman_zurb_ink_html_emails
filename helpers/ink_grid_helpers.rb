require_relative 'ink_base_module'

module InkGridHelpers
  include InkBaseModule

  def ink_container(options = {}, &block)
    return_ink_markup('container', options, &block)
  end

  def ink_row(options = {}, &block)
    return_ink_markup('row', options, &block)
  end

  def ink_column(size, options = {}, &block)
    options[:size] = size # it is always required, hence the required parameter
    options[:last] ||= false

    return_ink_markup('column', options, &block)
  end
end
