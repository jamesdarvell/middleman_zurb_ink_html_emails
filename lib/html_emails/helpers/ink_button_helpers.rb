module InkButtonHelpers
  include ::InkBasicHelpers

  BUTTON_TYPES = %w{button small-button tiny-button medium-button large-button}
  BUTTON_COLORS = %w{primary secondary alert success}
  BUTTON_RADII = %w{radius round}

  def ink_button(options = {}, &block)
    check_options_valid(options)

    options[:href] ||= '#'

    options[:classes] ||= []
    options[:classes] << correct_button_class(options)
    options[:classes] << correct_button_color_class(options)
    options[:classes] << correct_radius_class(options)

    return_ink_markup('button', options, &block)
  end

  def correct_button_class(options)
    # if there is a correct button class, add nothing
    return nil if (options[:classes] & BUTTON_TYPES).size > 0

    options[:size] ? "#{options[:size].to_s}-button" : "button"
  end

  def correct_button_color_class(options)
    # if there is a correct button color class, add nothing
    return nil if (options[:classes] & BUTTON_COLORS).size > 0
    return nil unless options[:color]

    raise 'Invalid button color' unless BUTTON_COLORS.include? options[:color].to_s

    options[:color].to_s
  end

  def correct_radius_class(options)
    # if there is a correct radius class, add nothing
    return nil if (options[:classes] & BUTTON_RADII).size > 0
    return nil unless options[:radius]

    raise 'Invalid button radius' unless BUTTON_RADII.include? options[:radius].to_s

    options[:radius].to_s
  end
end