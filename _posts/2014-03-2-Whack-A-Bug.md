--- 
layout: post 
title: Whack-a-Bug now online available
--- 

_Whack-a-Bug_ is one of the demos I will show at [VIZBI 2014]({{ site.baseurl }}{% post_url 2014-02-28-Poster-at-VIZBI2014 %}). After tinkering with it for a while to make it independent from the MASS Toolbox (web embedded [CDFs](https://www.wolfram.com/cdf-player/) don't like external dependencies ...) I was able to embed a live version of it here in this post. You might have to click on the panel first to be able to tease _E_. _coli_ (by removing its reactions one by one). Deleted reactions will be crossed out in red. A deletion can be reverted by clicking on the corresponding red cross. Have fun!

<script type="text/javascript" src="http://www.wolfram.com/cdf-player/plugin/v2.1/cdfplugin.js"></script>
<script type="text/javascript">
var cdf = new cdfplugin();
cdf.setDefaultContent('<a href="http://www.wolfram.com/cdf-player/"><img  src="{{ site.baseurl }}/cdf/StandaloneWhackABug.png"></a>');
cdf.embed('{{ site.baseurl }}/cdf/StandaloneWhackABug.cdf', 942, 678);
</script>