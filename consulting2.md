---
layout: accessibletwo
title: Consulting & Mentoring
---

{% include header_clean.html %}

<div class="wrap">
  <article class="post-wrap">
   <div class="post">
    <h1 style="margin-bottom: 0em;">{{page.title}}</h1>

<p>We do not believe in seagull consulting. We deliver pragmatic, hands on consulting services.</p>

<p>Our consulting engagements typically last from a few weeks to several months. We practice what we preach: continuously adding value and learning how to do better. Therefore we frequently inspect and adapt our approach and the value it adds to your organisation. You have the opportunity to conclude or extend the engagement at any time.</p>

   </div>
  </article>
</div>

<div class="trainingpage-layout">
  <h2>Services</h2>

  <div class="courses-grid">
  {% for service in site.consulting %}
    {% unless service.hide_in_index %}
      <article class="post-summary-wrap">
        <h3 class="entry-title">
          <a href="{{ service.url }}">{{ service.title }}</a>
        </h3>
        <div class="post-meta">{{ service.tagline }}</div>
        <p>{{ service.summary }}</p>
        <a class="btn read-more" href="{{ service.url }}">Read More</a>
      </article>
    {% endunless %}
  {% endfor %}
  </div>
