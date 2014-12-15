module InkGridHelpers
  def ink_container(options = {}, &block)
    return_ink_markup('container', options, &block)
  end

  def ink_row(options = {}, &block)
    return_ink_markup('row', options, &block)
  end

  private
  def return_ink_markup(name, options, &block)
    raise "Cannot have a #{name} without contents!" unless block_given?

    partial(
        "_partials/_ink/#{name}",
        :locals => {
            :content => capture_html(&block),
            :classes => options[:classes] || []
        }
    )
  end
end
