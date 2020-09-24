We often use the [Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern) for creating instances for t The `aValidNewSession` function is an instance of the [Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern). A _Builder_ separates the construction of a complex object from its representation. The `aValidNewSession` Builder provides an example `NewSession` with valid data. It lets us describe variations succinctly, for instance: `aValidNewSession({ participants: '31' })`.


Why did we introduce this instead of just calling the object's constructor? Often we just need an valid instance of something and we do not care about the specifics, sometimes we want to control only one specific field. Repeating constructor calls is tedious and creates unnecessary coupling in tests. 

In our JavaScript code the original Builder Pattern has less added value, because functions with default parameters can do the job just fine. The `aValidNewSession` function is an instance of such a function. It provides an example `NewSession` with valid data. It lets us describe variations succinctly like above, for instance: `aValidNewSession({ participants: '31' })`.



## Forces

- object is instantiated in many tests
- changing constructor is cumbersome (many changes all around the code) and error prone (connascense by position, shotgun surgery)
- only 1 or 2 values are relevant for the test, the rest is irrelevant;


## Solution

test object creation builder factory

in code

@@voorbeeld tests

## Consequences

