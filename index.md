---
layout: homepage
title: Home
tagline: 
---
{% include JB/setup %}


<div class="row text-center">
  <img src="{{ BASE_PATH }}/images/me.png" alt="Me" />

  <p>Liverpool based developer, mostly C#, Javascript but I dip my toes in various other technologies</p>	

	<ul class="posts">
		<h1>Latest Post:</h1>
		{% for post in site.posts limit:1 %}
			<span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
		{% endfor %}
		<h1>Other Recent Posts:</h1>
		{% for post in site.posts offset:1 limit:2 %}
			<span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
		{% endfor %}
		
	</ul>

</div>

