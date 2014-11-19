---
layout: page
title: Home
tagline: Supporting tagline
---
{% include JB/setup %}


## About

<img src="{{ BASE_PATH }}/images/me.jpg" alt="Me" />
<img src="{{ ASSET_PATH }}/images/rss.png" alt="Subscribe to RSS Feed" />

<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

