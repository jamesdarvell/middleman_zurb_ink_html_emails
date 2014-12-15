module InkBaseModule
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