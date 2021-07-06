Overzicht & werklijst van heuristics/guidelines


**Guidelines & heuristics for TDD & (unit) tests**
V Think about design in the test
V Wishful thinking
V Start with the expectation
> 0, 1, N
> Act stupid in implementation
> Faking & Cheating
~ One (conceptual) assert per test
~ Given-When-Then (or Arrange-Act-Assert)
~ Test name describes the action and the expected result
- Triangulation
- (new) Removing duplication between test & production code
- Make the change easy, then make the change (refactor after and before)
- Test cases follow common setup
- Take as much care for test code as you do for production code
- Tests are independent - always start from a clean slate
- No more than one failing test at a time
- Fix one failing test at a time
- What is a unit test?
- (new) Mirroring
- (new) Focus on relevant data (TDD by example: "Evident data")

- What is a heuristic
 - http://wirfs-brock.com/blog/2019/03/20/growing-your-personal-design-heuristics/

**Other**
- Rules for simple design
- Practice, Practice, Practice
- Sometimes we thank a test for its' service and move on
- Test behaviour rather than state

Principles?
- YAGNI
- OAOO, DRY
- DTSTTCPW

