def inline_ink_css
  ink_css =  minimize_css(IO.read(File.dirname(__FILE__) + '/../css/ink.css'))

  "<style type='text/css'>#{ink_css}</style>"
end

def minimize_css(css)
  css.gsub("\n", '').gsub(/\/\*[^*]*\*\//, '').gsub(/\s*([}{;:!,])\s*/, '\1' )
end