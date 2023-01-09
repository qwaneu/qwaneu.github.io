# Prefactoring 

Refactoring is the last _and_ the first step of the tdd cycle.

(TODO image of cycle)

Doing it first lets you:

- (when using [[file:20210114084706-pull_requests.org][Pull Requests]]) create smaller pull requests with only refactoring
- not rush into finishing the feature, but follow the [[file:20201217214859-the_principle_of_least_damage.org][The Principle of Least Damage]], especially in legacy code. This is also known as prefactoring.
- think about the design all the time, before, during and after writing the code.
- add tests in difficult places. Missing a place to inject a collaborator? Refactor first to add it, then add the test. With good tools, the call-sites don't have to change (example in C++? from Dirty Jobs? )

# Further reading

https://twitter.com/KentBeck/status/250733358307500032



#+begin_quote
for each desired change, make the change easy (warning: this may be hard), then make the easy change
#+end_quote
12:07 AM · Sep 26, 2012·TweetDeck

kevin rutherford
@kevinrutherford
·
Sep 26, 2012
Replying to
@KentBeck
@KentBeck
 Nice. And I think I'd rather say "for the next necessary change..." #yagni

