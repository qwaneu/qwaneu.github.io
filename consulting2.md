---
layout: accessibletwo
title: Consulting & Mentoring
---

{% include header_clean.html %}

<div class="wrap">
  <article class="post-wrap">
   <div class="post">
    <h1 style="margin-bottom: 0em;">{{page.title}}</h1>

<p>We deliver <strong>pragmatic</strong>, <strong>hands on</strong> consulting services. What works well for an organization is highly <strong>situational</strong>. We don't "install" standard methods or frameworks, but we tailor our approach to what fits your organization. Our approach is <strong>participative</strong> - we work with you to discover what is valuable and what is feasible.</p>

<p>Our consulting engagements typically last from a few weeks to several months. We practice what we preach: continuously adding value and learning how to do better, frequently inspect and adapt our approach and the value it adds to your organisation. You have the opportunity to conclude or extend the engagement at any time.</p>

   </div>
  </article>
</div>

<div class="trainingpage-layout">
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
