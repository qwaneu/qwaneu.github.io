---
layout: post
title: Test Data Builders
tags:
  - design, test driven development
author: Marc Evers, Rob Westgeest
image: 
---

We often use the [Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern) for creating object instances in our automated tests. In our recent post on [A Hexagonal Vue.js front-end, by example](/2020/09/25/hexagonal-frontend-example.html), we showed some of our JavaScript test code that contained a `aValidNewSession` function. In this post we will elaborate a bit on the what & why.

## Context 

Let's zoom in on the `NewSession` object that we used in the [previous
post](/2020/09/25/hexagonal-frontend-example.html). It is used by a UI component
(`NewDiagnosticSession`) for creating a new session. Creating can only proceed
if all the NewSession object's properties have valid values. It looks like this:

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

> Note that the NewSession constructor is empty. This is somewhat atypical for a javascript object. We do this because NewSession is used as a model for the form of a new session, which starts out empty. You may want to pass the values for its properties as constructor parameters in other cases.

If we want to write a test for checking the validity of the number of
participants, we need to create a `NewSession` with all valid properties, except
for participants. It would like this:

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
    ...
  })
```

We have 6 lines for setting up the object under test. Most of the values should
be valid values, but their specific value is irrelevant. This obfuscates the
value that is relevant for the test, namely the `'31'` for `participants`.

Another issue with this approach is that we will have more tests involving
NewSession and each test will have a similar setup. If we need to extend
NewSession with a new property, we need to make sure we update all the tests
where instances are created, even though most of those tests do not care about
the specific value of the new property.

A number of forces are at play here:

- an object is instantiated in many tests;
- changing object construction is cumbersome and error prone, it requires many
  changes all around the code - the [Shotgun Surgery code
  smell](https://blog.ndepend.com/shotgun-surgery/);
- only 1 or 2 values are relevant for the test, the rest is irrelevant and
  obfuscates what the intent of the test;
- we could add default values to the production code, but unless the defaults
  have meaning and use within our domain, the defaults increase the risk of
  errors by accidentally using a default value.

## Solution

Instead of instantiating a new `NewSession` object and providing all the values, we use a special builder function `aValidNewSession` that provides valid default values. In the test, we can focus on the `participants` property and give it a value that is out of range:

```javascript
describe('A new session', () => {
  it('is not valid if there are more than 30 participants', () => {
    const newSession = aValidNewSession({ participants: '31' })
    newSession.validate()
    expect(newSession.isValid()).toBe(false)
    ...
  })
```

The `aValidNewSession` function is an instance of the [Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern). A _Builder_ separates the construction of a complex object from its representation. The `aValidNewSession` Builder provides an example `NewSession` with valid data. It lets us describe variations succinctly, for instance: `aValidNewSession({ participants: '31' })`.



> The original _Builder_ often looks a bit more like:
```java
new SomeBuilder().withThis("stuff").withThat("other stuff").build()
```
The _intent_ of the _Builder_ remains the same. See further down this post for examples in different languages.

Why did we introduce this instead of just calling the object's constructor?
Often we just need an valid instance of something and we do not care about the
specifics, sometimes we want to control only one specific field. Repeating
constructor calls is tedious and creates unnecessary coupling in tests. 

In our JavaScript code the original Builder Pattern has less added value,
because functions with default parameters can do the job just fine. The
`aValidNewSession` function is an instance of such a function. It provides an
example `NewSession` with valid data. It lets us describe variations succinctly
like above, for instance: `aValidNewSession({ participants: '31' })`.

The `aValidNewSession` builder function is implemented like this, using ECMAScript
6 destructuring for function parameters and default values:

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

We provide sensible example values for a newSession, so that we can be sure
`aValidNewSession()` returns a valid object.

We apply the same pattern in Python as well, leveraging the Python **kwargs
feature (keyword arguments that behave like a dictionary), where we have a
dictionary with default values that are overridden by any specific values
provided. In our online Agile Fluency Diagnostic application, we have a
`Question` class and a corresponding `aValidQuestion` builder function.

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

`aValidID('55')` is another builder function that creates a valid UUID containing '55' or some other numbers.

In Java we would create a more DSL (domain specific language) like builder:
~~~java
aValidQuestion().forZoneFocusing().withAnswer(Choice.YES).build();
~~~ 
~~~java
class QuestionBuilder {
    public static UUID aUUID() {
        return UUID.fromString("de8841ab-3552-4525-a3c8-b584797bc79c");
    }

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

The implementation of test data builders depends a bit on the programming
language used and the features it offers. In a language like Java it is a bit
more verbose than for instance in Python.

## On styles of builders

The advantage of JavaScriptic and Pythonic `aValidThing({ attr: 'such' })` is that there is hardly any effort in creating these functions. Often they are good enough. There are a few upsides to the classic builder style as well.

### Readability and the help of the IDE

When object structures become more complicated, simple builder functions become harder to read. For example: [Vue.js](https://vuejs.org/) comes with testing support, allowing you to `mount` a local `Vue` environment, creating some `vue wrapper` to interact with. 

This `mount` method has defaults for many properties. It is hard to remember what you need for a component test. In some cases you need a real router, real I18N, etc., and sometimes things must be instantiated _in the right order_. 

So we created a builder around the Vue test utils allowing us to do things like:

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

### Partial objects

The classical style of builders makes it possible to create a partial object in a local test function that you finalize and build in the test:

~~~java
public class TestAnswering() {
  @Test
  public void test.....() {
    Question question = build(aFocusingQuestion().withLetter("X"))
    // ....
  }
  private QuestionBuilder aFocusingQuestion() {
    return aValidQuestion().forZone(Zone.Focusing);
  }
}
~~~

This is a bit harder to do with the function style builders.


## Consequences

- This pattern allows us to **express valid (and invalid) examples of our objects explicitly**. For instance: `aValidOrder().withItems(...).thatHasBeenPaid().build()`. This makes our test much more expressive.
- **Setup code in tests is reduced**, resulting in more succinct tests.
- We **reduce duplicated values** for object instances, because we can often depend on the default values provides by the builder.
- The pattern allows us to express the relevant details in our test explicitly and ignore the irrelevant details. If the date of a session is relevant to a test, but not the team name, we can use `aValidSession({ date: '2020-10-07 })` in the test instead of `new Session({ team: 'Team A', date: '2020-10-07', participants: 3 })`. It becomes **more clear what the test is actually about**.
- We greatly **reduce dependencies on the constructor**. Changing the constructor signature of widely used objects is usually painful. Changes to builders are much easier to manage because of the default values.
- Writing the builder is **a bit of extra code**. The extra effort is small, the pay off big. If we create a builder DSL, we usually add builder methods on the fly, when we need them, reducing the up-front investment.

> **Where to put builder code?**  
It is test code, so we tend to put it in a separate builders.[js|py|java|...] file in our domain test code. Sometimes we put it next to the production classes.

> **When to introduce builders?**  
At the start there are just one or a few tests that instantiate domain objects, so there seems not much added benefit of starting out with builders. If we introduce them later on, we find ourselves refactoring quite a few tests to move to builders. So we like to introduce them sooner rather than later.

> **Should builders be tested as well?**  
Although builders can be quite a few lines of code, we don't write tests for our builders. The builder code itself is pretty straightforward and we tend to test them via the tests that use them, especially through the fail step - seeing a new test fail first, to check our assumptions and verify the test's feedback quality.

## Conclusion

We really like test data builders. It is a pattern where the benefits hugely outweigh the small investment in a bit of builder code. They make your tests more focused and readable, and provide a very succinct but expressive way of describing your test setup.

This pattern is universally applicable, but its specific form can vary from programming language to programming language.

<aside>
  <h3>Bla</h3>
  <p>Bla</p>
  <p><div>
    <a href="/consulting">Learn more about our mentoring and coaching services</a>
  </div></p>
</aside>
