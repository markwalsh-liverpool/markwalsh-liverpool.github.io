---
layout: homepage
title: Home
tagline: 
---
{% include JB/setup %}


<div class="row text-center">
  <img src="{{ BASE_PATH }}/images/me.png" alt="Me" />
  <br>
  <h3>Profiles</h3>
  <a class="devicon-link" href="http://stackoverflow.com/users/1001408/mark-walsh"><span class="devicons devicons-stackoverflow"></span></a>
  <a class="devicon-link" href="https://github.com/markwalsh-liverpool"><span class="devicons devicons-github_badge"></span></a>
  <br>
  <h3>XP</h3>
  <span class="devicons devicons-netmagazine"></span>
  <span class="devicons devicons-visualstudio"></span>
  <span class="devicons devicons-msql_server"></span>
  <span class="devicons devicons-git"></span>
  <span class="devicons devicons-github_full"></span>
  <span class="devicons devicons-mongodb"></span>
  <span class="devicons devicons-scrum" alt="Scrum"></span>
  <span class="devicons devicons-ruby_rough"></span>
  <span class="devicons devicons-ruby_on_rails"></span>
  <span class="devicons devicons-responsive"></span>
  <span class="devicons devicons-yeoman"></span>
  <span class="devicons devicons-redis"></span>
  <span class="devicons devicons-chrome"></span>
  <span class="devicons devicons-npm"></span>
  <span class="devicons devicons-gulp"></span>
  <span class="devicons devicons-bower"></span>
  <span class="devicons devicons-grunt"></span>
  <span class="devicons devicons-jekyll_small"></span>
  <span class="devicons devicons-html5"></span>
  <span class="devicons devicons-css3_full"></span>
  <span class="devicons devicons-bootstrap"></span>
  <span class="devicons devicons-markdown"></span>
  <span class="devicons devicons-nodejs_small"></span>
  <span class="devicons devicons-javascript"></span>
  <span class="devicons devicons-jquery"></span>
  <span class="devicons devicons-angular"></span>
  <br>
  <h3>Bio</h3>
  <br>
  <p>26, Liverpool, United Kingdom</p>	



</div>
<div>
	<ul class="posts">
		<h4>Latest Post</h4>
		{% for post in site.posts limit:1 %}
			<span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
		{% endfor %}
		<h4>Other Recent Posts</h4>
		{% for post in site.posts offset:1 limit:2 %}
			<span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
		{% endfor %}
		
	</ul>
</div>



