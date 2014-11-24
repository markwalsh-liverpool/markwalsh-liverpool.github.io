---
layout: homepage
title: Home
tagline: 
description: Blog of Mark Walsh, Liverpool based developer using .Net, Javascript
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
  <span title=".Net" class="devicons devicons-netmagazine"></span>
  <span title="Visual Studio" class="devicons devicons-visualstudio"></span>
  <span title="MSSQL" class="devicons devicons-msql_server"></span>
  <span title="Github" class="devicons devicons-github_full"></span>
  <span title="MongoDb" class="devicons devicons-mongodb"></span>
  <span title="Ruby" class="devicons devicons-ruby_rough"></span>
  <span title="Responsive Design" class="devicons devicons-responsive"></span>
  <span title="NPM" class="devicons devicons-npm"></span>
  <span title="Gulp" class="devicons devicons-gulp"></span>
  <span title="Bower" class="devicons devicons-bower"></span>
  <span title="Grunt" class="devicons devicons-grunt"></span>
  <span title="Jekyll" class="devicons devicons-jekyll_small"></span>
  <span title="HTML5" class="devicons devicons-html5"></span>
  <span title="CSS3" class="devicons devicons-css3_full"></span>
  <span title="Bootstrap" class="devicons devicons-bootstrap"></span>
  <span title="Javascript" class="devicons devicons-javascript"></span>
  <span title="JQuery" class="devicons devicons-jquery"></span>
  <span title="AngularJS" class="devicons devicons-angular"></span>
  <br>
  <h3>Bio</h3>
  <p>26, Liverpool, United Kingdom</p>
  <br>	
  <ul style="padding: 0 !important;margin: 0 !important;list-style-type: none;">
		<h4>Latest Post</h4>
		{% for post in site.posts limit:1 %}
			<li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
		{% endfor %}
		<h4>Other Recent Posts</h4>
    {% if site.posts.count > 1 %}
  		{% for post in site.posts offset:1 limit:2 %}
  			<li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  		{% endfor %}
		{% endif %}
	</ul>
</div>