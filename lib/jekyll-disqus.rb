require "jekyll-disqus/version"

module Jekyll
  class DisqusTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @disqus_name = text.strip
    end

    def render(context)
      if @disqus_name.empty?
        @disqus_name = context.registers[:site].config["disqus"]["username"]
      end

      return "" if @disqus_name.empty?
      
      html = <<-EOB
<script>
var disqus_shortname = '#{@disqus_name}';
(function() {
  var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
  dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
  (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
})();
</script>
EOB
      html
    end
  end
end

Liquid::Template.register_tag('disqus', Jekyll::DisqusTag)