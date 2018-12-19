require 'jekyll'
require_relative 'jekyll/pocket'

ROOT_STRING = '~~&&~~JEKYLL~~&&~POCKET~&&~~ROOT~~&&~~'

if !!(ENV['JEKYLL_ENV'] == 'pocket')
  Jekyll::Hooks.register :site, :after_init do |site|
    site.config['baseurl'] = ROOT_STRING
    site.config['permalink'] = 'none'
  end

  Jekyll::Hooks.register :site, :post_write do |site|
    files = Dir.glob("#{site.dest}/**/*").select { |f| File.file?(f) }
    files.each do |file|
      prefix  = Jekyll::Pocket.depth_prefix(site.dest, file)
      content = File.read(file)

      single_quote_matches = content.scan(/['].?#{ROOT_STRING}[^']*[']/)
      double_quote_matches = content.scan(/["].?#{ROOT_STRING}[^"]*["]/)

      single_quote_matches.concat double_quote_matches.each do |match|
        result = match.gsub(/\/#{ROOT_STRING}\//, prefix).gsub(/["']/, '')
        result += 'index.html' if result.empty? || result.end_with?('/')

        content.gsub!(match, result)
      end

      File.write(file, content)
    end
  end
end
