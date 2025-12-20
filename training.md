---
title: Training Courses
layout: accessibletwo
---

{% include header_clean.html %}

<div class="wrap">
  <article class="post-wrap">
   <div class="post">
    <h1 style="margin-bottom: 0em;">{{page.title}}</h1>

<p>Our training courses are intensive and hands-on. We work with small groups up to 14 participants to ensure an optimal learning experience. We offer both open enrolment courses and customized in-company courses, on-site and remote. </p>

<p>We deliver our courses in English, Dutch, German or French (together with our German and French partners).
Programming exercises are available in Java, C#, C++, Scala, Ruby, Python, JavaScript, and TypeScript.</p>

<p>If you have a need that is not covered by an existing course, <a href="/contact">we are happy to make a new one for you</a>. Our best courses got started by specific requests from our customers!</p>

   </div>
  </article>
</div>

<div class="trainingpage-layout">
  <h2>Training courses (1 or more days)</h2>

  <div class="courses-grid">
  {% for course in site.training %}
    {% unless course.hide_in_index %}
      <article class="post-summary-wrap">
        <h3 class="entry-title">
          <a href="{{ course.url }}">{{ course.title }}</a>
        </h3>
        <div class="post-meta">{{ course.tagline }}</div>
        <p>{{ course.summary }}</p>
        <a class="btn read-more" href="{{ course.url }}">Read More</a>
      </article>
    {% endunless %}
  {% endfor %}
  </div>

  <h2>Workshops (1/2 day)</h2>

  <div class="courses-grid">
  {% for course in site.workshops %}
    {% unless course.hide_in_index %}
      <article class="post-summary-wrap">
        <h3 class="entry-title">
          <a href="{{ course.url }}">{{ course.title }}</a>
        </h3>
        <div class="post-meta">{{ course.tagline }}</div>
        <p>{{ course.summary }}</p>
        <a class="btn read-more" href="{{ course.url }}">Read More</a>
      </article>
    {% endunless %}
  {% endfor %}
  </div>

  <!-- <div style="text-align: center;">
    <img src="/images/agile_engineering_wordle.png" style="max-width: 50%;"> 
  </div> -->

</div>
