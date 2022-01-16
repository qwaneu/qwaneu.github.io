## Test cases follow common setup

Do you need a different setup for some of the tests? A different setup is a different situation, 
you're testing a different aspect of the object's behaviour. We put that in a separate
Test Case that describes that behaviour.

This will prevent our test being cluttered with all kind of different setups and situations.
The test becomes cleaner and easier to understand.

```ruby
class MachineTest
  def test1
    # sets up filled machine
  def test2
    # sets up filled machine
  def test3
    # sets up empty machine

# Split the tests:
class FilledMachineTest
  def test1
  def test2

class EmptyMachineTest
  def test3
```
