def inline_ink_css
  ink_css =   IO.read(File.dirname(__FILE__) + '/../css/ink.css')
  ink_css +=  @user_css if @user_css

  "<style type='text/css'>#{minimize_css(ink_css)}</style>"
end

def ink_css(&block)
  @user_css = (@user_css || '') + remove_cdata(capture_html(&block).gsub(/<[\/]?style[^>]*>/, ''))
  ''
end

def minimize_css(css)
  css.gsub("\n", '').gsub(/\/\**[^*]*\**\//, '').gsub(/\s*([}{;:!,])\s*/, '\1' )
end

def remove_cdata(css)
  css.gsub(/(\/\*)?(<!\[CDATA\[>?|\]+>)(\*\/)?/ ,'')
end