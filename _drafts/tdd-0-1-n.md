---
layout: post
title: "TDD Heuristics: 0, 1, N"
tags:
  - test driven development
  - feedback
  - eXtreme Programming
author: Marc Evers, Willem van den Ende, Rob Westgeest
image: /attachments/blogposts/2021/tdd/0-1-N.jpg
---

Where do we start when test-driving a new piece of code? All options are open,
but we risk getting stuck because of the blank-piece-of-paper feeling. Because
we want to take small steps towards the end result, use the 0, 1, N guideline:
we start with some 'zero' or edge case, then make it work for a single case,
then generalize it to multiple cases.

![0-1-N.jpg](/attachments/blogposts/2021/tdd/0-1-N.jpg)
{: class="post-image post-image-50" }

## Zero

We start with the 'zero' case, e.g. there is nothing available, there is no
supply, there are no choices to be made. This could also be a negative case,
like an order that cannot be found. We might already be thinking of next test
cases, but to keep focus, we move these out of our heads and park them on our
todo list - see e.g. [TDD with a
list](https://www.sammancoaching.org/learning_hours/small_steps/tdd_with_a_list.html).

The 'zero' case is usually straightforward to implement in a simple way; often
we can just fake it. It does allow us to get the basics in place, like a new
class with a method having the correct signature. We can postpone more
complicated decisions about data structures, iteration, mapping, etc. We get a
bit of feedback earlier on and we buy ourselves some time to think about the
code we're growing.

Let's look at an example from our [Online Agile Fluency® Diagnostic
application](/2020/09/25/hexagonal-frontend-example.html). This application
supports a facilitator in running a workshop with a development team where team
members fill in a survey. The facilitator can download the aggregated survey
results - called a *Rollup* or Rollup Chart - in CSV format. The CSV contains a
line per survey question.

To test drive the conversion from the Rollup and Survey domain objects to CSV,
we start with the zero case: no survey questions. This should return a CSV with
just the column headings:

```python
class TestMappingRollupToCSV:
  def test_creates_csv_with_a_line_per_rollup_question(self):
    questionnaire = aQuestionnaire()
    rollup = Rollup.empty_rollup(questionnaire,
                                 facilitator_name='the facilitator',
                                 team='Team')

    assert as_rollup_csv(rollup) == dedent('''\
          id,question,zone,consensus,consensus value''')
```

The function as_rollup_csv is the code-under-test. The Python `dedent` function
is just for convenience, it removes leading and trailing spaces and preserves
line breaks, so that we can layout our expected value in a more readable way.

We make this test work by implementing just the bare minimum:

```python
def as_rollup_csv(rollup):
    return 'id,question,zone,consensus,consensus value'
```

## One

After we have implemented the 'zero' case, we write a test for the singular
case. We focus on getting the code to work for just this case. Even if we are
already thinking of a generic solution with dictionaries, collections, or
streams, we postpone this for now. We will get to that in the 'N' step.

For the Rollup to CSV conversion, we add a test for a single survey question:

```python
  def test_creates_csv_with_a_line_for_a_rollup_question(self):
    questionnaire = aQuestionnaireWithQuestions(
            aValidQuestion(id=aValidID(33), letter='A',
                           question_text='one,two,three',
                           zone=Zone.Optimizing))
    rollup = Rollup.empty_rollup(questionnaire,
                                 facilitator_name='the facilitator',
                                 team='Team')

    assert as_rollup_csv(self.rollup) == dedent('''\
            id,question,zone,consensus,consensus value
            A,"one,two,three",optimizing,,''')
```

We update the production code, but again we don't do more than strictly necessary. We only make it work for the first question in the list.

```python
def as_rollup_csv(rollup):
  q = rollup.rollup_questions[0]
  lines = ['id,question,zone,consensus,consensus value']
  lines = lines + ['{letter},"{question_text}",{zone},{consensus_label},{consensus}'.format(
          letter=q.letter, 
          question_text=q.question_text, 
          zone=str(q.zone), 
          consensus_label=as_consensus_label(q.consensus), 
          consensus=as_consensus_value(q.consensus))]
  return '\n'.join(lines)
```

## Many

After we have finished the singular case, we write a test for multiple cases.
This test forces us to generalize the code. By taking the 0 and 1 steps first,
we have given our brain some extra time to percolate on a good design.

We write a test that involves more than one survey question:

```python
  def test_creates_csv_with_a_line_per_rollup_question(self):
    questionnaire = aQuestionnaireWithQuestions(
            aValidQuestion(id=aValidID(33), letter='A',
                           question_text='one,two,three',
                           zone=Zone.Optimizing),
            aValidQuestion(id=aValidID(44),letter='B',
                           question_text='something', 
                           zone=Zone.Optimizing))
    rollup = Rollup.empty_rollup(questionnaire,
                                 facilitator_name='the facilitator',
                                 team='Team')

    assert as_rollup_csv(self.rollup) == dedent('''\
            id,question,zone,consensus,consensus value
            A,"one,two,three",optimizing,,
            B,"something",optimizing,,''')
```

To make this work, we transform the list we already had into a list
comprehension:

```python
def as_rollup_csv(rollup):
    lines = ['id,question,zone,consensus,consensus value']
    lines = lines + ['{letter},"{question_text}",{zone},{consensus_label},{consensus}'.format(
            letter=q.letter, 
            question_text=q.question_text, 
            zone=str(q.zone), 
            consensus_label=as_consensus_label(q.consensus), 
            consensus=as_consensus_value(q.consensus)) for q in rollup.rollup_questions]
    return '\n'.join(lines)
```

Our three tests have some duplication. Now that our production code is ok, we
can refactor our tests. We could drop the first two tests now, because the
`test_creates_csv_with_a_line_per_rollup_question` test sufficiently covers the
headings and iteration over questions. Does this mean we wasted time and
characters on those tests? No, the tests were helpful in getting to our goal in
baby steps.

## Effects

The 0, 1, N guidelines helps getting over that 'blank piece of paper' feeling,
which is often the biggest hurdle to get started. You don't need to have a
complete overview of all the next tests to write. You are likely to find more
cases after you start,

Starting with a negative case prevents you from only writing tests for the happy
flow. It is often the smallest step you can take. Completing a step feels good
and prepares you to take the next. Before you know it you may have a whole suite
of these things.

## Further reading

The 0, 1, N heuristic is related to the _Starter Test_ and _One to Many_
patterns in the [Test Driven Development, By Example](https://www.oreilly.com/library/view/test-driven-development/0321146530/) book by Kent Beck.

[James Grenning proposed the ZOMBIES acronym](http://blog.wingman-sw.com/tdd-guided-by-zombies) for writing tests:
- (Z)ero
- (O)ne
- (M)any
- (B)oundary behaviors
- (I)nterface definition
- (E)xercise exceptional behaviour
- (S)imple scenarios-simple solutions.

_This is a post in our [series on Test Driven Development](/blog-by-tag#tag-test-driven-development)._

<aside>
  <p>Join us for one of our Test Driven Development courses. Deliberate practice and learning by doing may make your wishes come true..
  </p>
  <p><div>
    <a href="/training/test-driven-development">Find out more</a>
  </div></p>
</aside>
