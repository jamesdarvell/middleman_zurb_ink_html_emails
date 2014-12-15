require_relative 'ink_base_module'

module InkContentHelpers
  include InkBaseModule

  def ink_panel(options = {}, &block)
    return_ink_markup('panel', options, &block)
  end
end