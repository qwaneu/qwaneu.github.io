---
layout: post
title: Test Data Builders
tags:
  - design, test driven development
author: Marc Evers, Rob Westgeest
image: /attachments/blogposts/2020/house-scaffolding.jpg
---

Imagine you grow a suite of automated tests that serve you well, but you are struggling to read through them. Quite a bit of repetition and boilerplate that obfuscates what is going on in individual tests. [Builder](https://en.wikipedia.org/wiki/Builder_pattern) is a pattern that lets our tests reveal their intent more succinctly, at the cost of making a small investment in creating a builder for our domain concept under test.

We often use the [Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern) for creating object instances in our automated tests. In our recent post on [A Hexagonal Vue.js front-end, by example](/2020/09/25/hexagonal-frontend-example.html), we showed some of our JavaScript test code that contained a `aValidNewSession` builder function. In this post we will elaborate a bit on the what & why.

## Context 

Let's zoom in on that `NewSession` object we used in the [previous
post](/2020/09/25/hexagonal-frontend-example.html). It is used by the
`NewDiagnosticSession` UI component for creating a new session. Creating can
only proceed if all the `NewSession` object properties have valid values. It
looks like this:

```javascript
export class NewSession {
  constructor () {
    this.team = ''
    this.date = ''
    this.participants = ''
    this.language = defaultLanguage
    this._isTest = false
    this.errors = {}
  }
  ...
```

> Note that the `NewSession` constructor does not have any arguments. This is somewhat atypical for a JavaScript object. We do this because `NewSession` is used as a form model for a new session, which starts out empty. In other cases, you may want to pass the initial values as constructor parameters.

If we want to write a test to check if the number of participants is valid, we
need to create a `NewSession` with all valid properties, except for the number
of participants:

```javascript
describe('A new session', () => {
  it('is not valid if there are more than 30 participants', () => {
    const newSession = new NewSession()
    newSession.team = 'Team A'
    newSession.date = '2020-10-07'
    newSession.participants = '31'
    newSession.language = 'en'
    newSession.validate()
    expect(newSession.isValid()).toBe(false)
  })
```

We have 6 lines for setting up the object under test. Most of the values should
be valid, but their specific value is not relevant. This obfuscates the
value that is relevant for the test, namely the '31'.

Another issue with this approach is that we have more tests involving
`NewSession`, each with a similar setup. If we need to extend
`NewSession` with a new property, we need to make sure we update all these tests, even though most of them do not care about
the specific value of the new property.

A number of forces are at play here:
- an object is instantiated in many tests;
- changing object construction is cumbersome and error prone, it requires many
  changes all around the code - the [Shotgun Surgery code
  smell](https://blog.ndepend.com/shotgun-surgery/);
- only one or two values are relevant for the test, the rest is not relevant and
  obfuscates the test intent;
- we could add default values to production code, but unless the defaults
  are useful within our domain, they increase the risk of
  errors by accidentally using a default value.

## Solution

Instead of instantiating a new `NewSession` object and providing all required values, we use a special builder function `aValidNewSession` that provides valid default values. In the test, we can focus on the `participants` property and give it a value that is out of range:

```javascript
describe('A new session', () => {
  it('is not valid if there are more than 30 participants', () => {
    const newSession = aValidNewSession({ participants: '31' })
    newSession.validate()
    expect(newSession.isValid()).toBe(false)
  })
```

The `aValidNewSession` function is an instance of the [Builder
pattern](https://en.wikipedia.org/wiki/Builder_pattern). A _Builder_ separates
the construction of a complex object from its representation. The
`aValidNewSession` builder function provides an example `NewSession` with valid
data. It lets us describe variations succinctly: 
```javascript
aValidNewSession({ participants: '31' })
```

So why did we introduce this instead of just calling the object's constructor?
Often we just need an valid instance and we do not care about the specifics,
sometimes we want to control one specific field. Repeated constructor calls are
tedious to write and create unnecessary coupling. 

> The original _Builder_ often looks more like:
```java
new SomeBuilder().withThis("stuff").withThat("other stuff").build()
```
There are different ways of implementing this pattern, but the _intent_ of
_Builder_ remains the same. See further down this post for examples in different
languages.

In our JavaScript example, the Builder Pattern in its original 'classic' form
has less added value, because functions with default parameters can do the job
just fine. The `aValidNewSession` function is an example of such a function. It
provides an example `NewSession` with valid data and lets us describe variations
succinctly.

The `aValidNewSession` builder function is implemented like this, using default
values and ECMAScript 6 destructuring for function parameters:

```javascript
export function aValidNewSession ({ team = 'Team X', date = '2011-11-12', 
    participants = '10', language = 'en', isTest = false } = {}) {
  const validSession = new NewSession()
  validSession.team = team
  validSession.date = date
  validSession.participants = participants
  validSession.language = language
  validSession.isTest = isTest
  return validSession
}
```

We provide sensible values for a newSession, so that `aValidNewSession()` returns a new session with all valid properties.

We apply the same pattern in Python as well, leveraging the Python `**kwargs`
feature (keyword arguments in the form of a dictionary). The `validArgs`
dictionary provides default values which can be overridden by specific values
provided. In our online Agile Fluency Diagnostic application, we have a
`Question` class with a `aValidQuestion` builder function.

~~~python
@dataclass    
class Question:
    id: any
    letter: str
    question_text: str
    zone: Zone
    ...
def aValidQuestion(**kwargs):
    validArgs = dict(id = aValidID('55'), letter='A.', zone=Zone.Focusing, question_text='Whoot?')
    return Question(**{**validArgs, **kwargs})
~~~

`aValidID('55')` is another builder function that creates a valid UUID.

In Java we would create a classic builder, with a small DSL (domain specific language).

~~~java
aValidQuestion().forZone(Zone.Focusing).withAnswer(Choice.YES).build();
~~~ 
~~~java
class QuestionBuilder {
    public static QuestionBuilder aValidQuestion() {
        return new QuestionBuilder()
                .withId(aUUID())
                .withLetter("A.")
                .withQuestionText("Whoot!")
                .forZone(Zone.Focusing);
    }

    private UUID id;
    private String letter;
    private String questionText;
    private Zone zone;

    public QuestionBuilder withId(UUID id) {
        this.id = id;
        return this;
    }
    public QuestionBuilder withLetter(String letter) {
        this.letter = letter;
        return this;
    }
    public QuestionBuilder withQuestionText(String questionText) {
        this.questionText = questionText;
        return this;
    }
    public QuestionBuilder forZone(Zone zone) {
        this.zone = zone;
        return this;
    }
    public Question build() {
        return new Question(id, letter, questionText, zone);
    }
}
~~~

The specific implementation of test data builders depends on the programming
language used and the features it offers. In a language like Java it is
more verbose than for instance in Python.

## On builder styles

The advantage of JavaScriptic and Pythonic `aValidThing({ attr: 'such' })` is
that there is hardly any effort in creating these functions. Often they are good
enough. There are a few upsides to using classic builders as well.

### Readability and the help of the IDE

When object structures become more complicated, simple builder functions become
hard to read. [Vue.js](https://vuejs.org/) for example comes with testing
support, allowing you to _mount_ a local Vue environment, creating a _vue
wrapper_ to interact with. The `mount` function has defaults for many
properties. It is hard to remember what you need for a component test. In some
cases you need a real router or I18N, sometimes a mock or stub, sometimes you need to instantiate things _in the right order_. 

So we created a builder around [Vue Test Utils](https://vue-test-utils.vuejs.org/) that allows us to do things like:

```javascript
    aVueWrapperFor(TheDiagnosticSession)
      .withProps({ facilitatorModule, appInfoModule, sessionId })
      .thatStubs('router-link', 'FullscreenSpinner', 'v-icon')
      .mount()
```
or 
```javascript
    aVueWrapperFor(DiagnosticSessions)
      .withProps({ diagnosticSessions: sessions })
      .withRealIcons()
      .mount()
```

When you write a builder like this, you will get more help from your IDE via autocompletion than you get with builder functions.

### Partially built objects

The classic style of builders makes it possible to create a partially built object in a local test function, which you can finalize and build in the test:

~~~java
public class TestAnswering() {
  private QuestionBuilder aFocusingQuestion() {
    return aValidQuestion().forZone(Zone.Focusing);
  }

  @Test
  public void test...() {
    Question question = aFocusingQuestion().withLetter("X").build()
    ...
  }
}
~~~

## Consequences

Applying the test builder pattern has the following consequences:

- We can **express valid (and invalid) examples of our objects explicitly**, making our test much more expressive. For instance: `aValidOrder().withItems(...).thatHasBeenPaid().build()`
- **Setup code in tests is reduced**, resulting in more succinct tests.
- We can **reduce duplicated values** for object instances, because we can depend on the sensible defaults the builder provides.
- It becomes **more clear what a test is actually about**. We express relevant details explicitly and ignore the irrelevant details. If the date of a session is relevant to a test, but the team name not, we can use `aValidSession({ date: '2020-10-07 })` instead of `new Session({ team: 'Team A', date: '2020-10-07', participants: 3 })`. 
- We greatly **reduce dependencies on constructors**. Changing the constructor signature of widely used objects is painful. Changes to builders are easier to manage because of the default values.
- Writing the builder means **some extra code**. The extra effort is small, even in a more verbose language like Java, and the pay off is big. If we create a classic style builder, we can add new builder methods when needed, reducing up-front investment.

> **Where to put builder code?**  
Builder code is test code, so we tend to put it in a separate builders.js/py/java/... file sitting next to our domain test code. Sometimes we put it near the production classes.

> **When to introduce builders?**  
Initially, there are just a few tests that instantiate a domain object, so there seems not much added benefit of starting out with builders. If we introduce them later however, we find ourselves refactoring quite a few tests to move to builders. So we prefer to introduce them sooner rather than later.

> **Should builders be tested as well?**  
Although builders can be quite a few lines of code, we don't write tests for 
them. The builder code is straightforward and we test them via the tests that use them. The _fail_ step from the test driven development cycle - let a new test fail first, to check our assumptions and test feedback - is helpful here.

## Conclusion

We like test data builders. It is a pattern where the benefits outweigh the small investment in builder code. They make tests more focused and readable, and provide a succinct and expressive way of describing your test setup.

This pattern is widely applicable, but the specific form varies from programming language to programming language.

_Credits: Willem, thanks for dotting the i's in this post._

<aside>
  <h3>There is more to writing automated tests that add value</h3>
  <p>We run immersive courses on Test Driven Development that help improve your work soon after. We also upskill teams by mentoring or working hands-on. A well-calibrated set of tests helps you say 'yes we can' more often in a sustainable way.</p>
  <p><div>
    <a href="/training">Find out how our courses can support your work</a>
  </div></p>
</aside>
