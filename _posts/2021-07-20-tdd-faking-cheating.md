---
layout: post
title: "TDD Heuristics: Faking & Cheating"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
  - heuristics
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/pretend-play.png
---

Once we have a failing test, how do we get to green quickly?
If we can get away with faking it, we do that. It is sometimes the simplest way
to get the test to pass, and to remind us to write the next test case.

![pretend play - faking it](/attachments/blogposts/2021/tdd/pretend-play.png)
{: class="post-image post-image-50" }

Making a test pass by faking or cheating, for example by returning the expected
value as a constant, is an example of [acting dumb in
implementation](/2021/07/12/tdd-act-dumb-in-implementation.html). In TDD
cheating is allowed, we even recommend it! If you can get away with faking, it
means you need another test case to force yourself to write a more generic
implementation.

Faking might feel weird at the beginning, but it helps to proceed towards your 
goal in baby steps. You will make progress continuously. 

When we fake, we do it with simple code - no ifs, no boolean flags. We've
learned that if we try to fake with flags or ifs, we'll code ourselves into a
corner.

## Example 

Let's take another look at the Comma Separated Values (CSV) conversion code we
looked at in the [0, 1, N post](/2021/07/09/tdd-0-1-n.html). We were test
driving the conversion from aggregated survey results (represented by Rollup
domain object) to CSV.

We wrote a test for a survey with a single question, which should result in a
single line in the CSV (after the header line):

```python
  def test_creates_csv_with_a_line_for_a_rollup_question(self):
    survey = aSurveyWithQuestions(
            aValidQuestion(id=aValidID(33), letter='A',
                           question_text='one,two,three',
                           zone=Zone.Optimizing))
    rollup = Rollup.empty_rollup(survey,
                                 facilitator_name='the facilitator',
                                 team='Team')

    assert as_rollup_csv(self.rollup) == dedent('''\
            id,question,zone,consensus,consensus value
            A,"one,two,three",optimizing,,''')
```

We can implement this by cheating: we just return the literal string that we are
asserting.

```python
def as_rollup_csv(rollup):
  return 'id,question,zone,consensus,consensus value' + '\n' + \
         'A,"one,two,three",optimizing,,'
```

This is perfectly fine, as there is no test that asks for anything else. Because
faking like this feels awkward, it urges us to do something about it. 


There are two other techniques to resolve this that we use often use: 

- _Triangulation_: generalize based on two or more examples (but no less). We can write a next test that will force us to generalize the code.
- _Remove duplication beween code and test_: we can see it as a matter of
  duplication between the test code and the production code. The question values
  are both in the setup code of the test and in the fake production code. 

We will explain these later in this [series on Test Driven Development](/blog-by-tag#tag-test-driven-development).

## Effects

Faking helps us to do the Simplest Thing That Could Possibly Work - it prevents
us from introducing logic that we don't need yet - or that we don't need anyway.

Because faking helps to keep the code simple, it enables us to work at a higher
pace - more faster test-fail-code-refactor cycles.

Struggling with that awkward feeling? A different way of looking at faking and
cheating is that we initially provide a very specific implementation, which we
generalize later on. The fake is correct behaviour, but correct for a very
limited scope only. It is too specific, but good enough as a baby step towards
our goal.

## Further reading

In [Test Driven Development, By
Example](https://www.oreilly.com/library/view/test-driven-development/0321146530/),
Kent Beck introduced the _Fake It ('Til You Make It)_ pattern.

We have made extensive use of _The Simplest Thing That Could Possibly Work_ in [Act dumb in implementation](/2021/07/12/tdd-act-dumb-in-implementation.html).

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Faking makes more sense when you practice it. Join us for a Test Driven Development course in the fall.
  </p>
  <p><div>
    <a href="/training/test-driven-development">Check availability</a>
  </div></p>
</aside>
