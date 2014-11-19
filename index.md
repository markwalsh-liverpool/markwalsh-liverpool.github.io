---
layout: homepage
title: Home
tagline: 
---
{% include JB/setup %}


<div class="row text-center">
  <img src="{{ BASE_PATH }}/images/me.png" alt="Me" />
  <br>
  <h4>Technology Profiles</h4>
  <br>
  <a class="devicon-link" href="http://stackoverflow.com/users/1001408/mark-walsh"><span class="devicons devicons-stackoverflow"></span></a>
  <a class="devicon-link" href="https://github.com/markwalsh-liverpool"><span class="devicons devicons-github_badge"></span></a>
  <br>
  <br>
  <h4>Languages/Frameworks Used</h4>
  <br>
  <span class="devicons devicons-dotnet"></span>
  <br>
  <h4>Bio</h4>
  <br>
  <p>Liverpool based developer, mostly C#, Javascript but I dip my toes in various other technologies</p>	
  <br>
	<ul class="posts">
		<h5>Latest Post</h5>
		{% for post in site.posts limit:1 %}
			<span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
		{% endfor %}
		<h5>Other Recent Posts</h5>
		{% for post in site.posts offset:1 limit:2 %}
			<span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
		{% endfor %}
		
	</ul>

</div>

