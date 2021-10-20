Overzicht & werklijst van heuristics/guidelines


**Guidelines & heuristics for TDD & (unit) tests**
V [Think about design in the test](https://www.qwan.eu/2021/06/28/tdd-think-about-design-in-test.html)
V [Wishful thinking](https://www.qwan.eu/2021/07/01/tdd-wishful-thinking.html)
V [Start with expectation](https://www.qwan.eu/2021/07/05/tdd-start-with-expectation.html)
V [0, 1, N](https://www.qwan.eu/2021/07/09/tdd-0-1-n.html)
V [Act dumb in implementation](https://www.qwan.eu/2021/07/12/tdd-act-dumb-in-implementation.html)
V [Faking & Cheating](https://www.qwan.eu/2021/07/20/tdd-faking-cheating.html)
V [Test name describes the action and the expected result](https://www.qwan.eu/2021/07/27/tdd-naming-tests.html)
V [Given-When-Then or Arrange-Act-Assert](https://www.qwan.eu/2021/09/02/tdd-given-when-then.html)
V [One (conceptual) assert per test](https://www.qwan.eu/2021/08/27/tdd-one-assert-per-test.html)
V (new) [Glanceable tests](https://www.qwan.eu/2021/09/27/tdd-glanceable-tests.html)
V What is a heuristic
~ Triangulation
~ Caring for your tests
~ Fix one failing test at a time / No more than one failing test at a time
- (expanding) Rules for simple design
- (new) Removing duplication between test & production code
- (new) Make the change easy, then make the change (refactor after and before) source: Kent Beck
- Test cases follow common setup
- Tests are independent - always start from a clean slate
- What is a unit test?
- (new) Mirroring; James Shore calls this Collaborator-Based Isolation
 https://www.jamesshore.com/v2/blog/2018/testing-without-mocks#isolation
- (new) Focus on relevant data (TDD by example: "Evident data")
- start with a negative case (zit in [0, 1, N])
- (new) Composed Method, for tests / everything at same level of abstraction
- (new) factor out support code (not necessarily all common code, sometimes we need to re-tell a story)
- (new) the need for speed - why tests should be fast
 (see tests should be independent, what is a unit test, focus on relevant data)
- (new) Mind the failure feedback (draft post in willems' essays based on C++ enum that gives huh feedback)
  Based on Robs' remark for the afterword: maybe the enum is quick and convenient, but not the best representation given the hoops we have to jump through to let it give decent feedback. So whether we address it (e.g. in a training session) or not, depends on how long we plan to keep it around.
(reason: will you understand the failure tomorrow or next year?)
- (new) Make failing test without needing to change others
  (put on the board based on a training - it is tempting to change a bunch of tests e.g. when adding parameters). Also see: code golf.
- (new) pre-and post-conditions (see twitter thread with Steve Freeman)

**Other**
V [TDD still relevant in 2021](https://www.qwan.eu/2021/06/24/tdd-still-relevant-in-2021.html)
- Practice, Practice, Practice
- Sometimes we thank a test for its' service and move on
- Test behaviour rather than state

- simple acts of kindness and love
  Is gerelateerd, maar gaat niet direct over TDD. mischien in een post naar verwijzend.
  - elke test first is zo'n small act
  - refactoring, renaming zijn small acts
  - je CI verbeteren zodat je tests het laten falen is a small act
  - fix one failing test at a time is one 

Principles?
- YAGNI
- OAOO, DRY
- DTSTTCPW

