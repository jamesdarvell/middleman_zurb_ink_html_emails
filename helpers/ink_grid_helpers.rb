module InkGridHelpers
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

  private
  def return_ink_markup(name, options, &block)
    raise "Cannot have a #{name} without contents!" unless block_given?

    partial("_partials/_ink/#{name}", :locals => build_locals_hash(options, &block))
  end

  def build_locals_hash(options, &block)
    options[:classes] ||= []
    options.merge({
      :content => capture_html(&block)
    })
  end
end
