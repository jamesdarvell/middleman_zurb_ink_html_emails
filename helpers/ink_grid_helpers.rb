module InkGridHelpers
  def ink_container(&block)
    raise 'Cannot have a container without contents!' unless block_given?

    partial('_partials/_ink/container', :locals => {:content => capture_html(&block)})
  end
end
