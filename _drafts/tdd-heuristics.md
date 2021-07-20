Overzicht & werklijst van heuristics/guidelines


**Guidelines & heuristics for TDD & (unit) tests**
V [Think about design in the test](https://www.qwan.eu/2021/06/28/tdd-think-about-design-in-test.html)
V [Wishful thinking](https://www.qwan.eu/2021/07/01/tdd-wishful-thinking.html)
V [Start with expectation](https://www.qwan.eu/2021/07/05/tdd-start-with-expectation.html)
V [0, 1, N](https://www.qwan.eu/2021/07/09/tdd-0-1-n.html)
V Act dumb in implementation
V Faking & Cheating
~ Given-When-Then (or Arrange-Act-Assert)
~ One (conceptual) assert per test
~ Test name describes the action and the expected result
~ Triangulation
- (new) Removing duplication between test & production code
- (new) Make the change easy, then make the change (refactor after and before) source: Kent Beck
- Test cases follow common setup
- Take as much care for test code as you do for production code
- (new) Glanceable tests
- Tests are independent - always start from a clean slate
- No more than one failing test at a time
- Fix one failing test at a time
- What is a unit test?
- (new) Mirroring
- (new) Focus on relevant data (TDD by example: "Evident data")
- start with a negative case (zit in [0, 1, N])
- (new) Composed Method, for tests / everything at same level of abstraction

- What is a heuristic
 - http://wirfs-brock.com/blog/2019/03/20/growing-your-personal-design-heuristics/

**Other**
V [TDD still relevant in 2021](https://www.qwan.eu/2021/06/24/tdd-still-relevant-in-2021.html)
- Rules for simple design
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

