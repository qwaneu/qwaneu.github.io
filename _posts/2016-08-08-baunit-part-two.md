---
layout: post
title:  Test Drive a unit testing framework in bash part two
tags: 
  - code
  - bash
author: Rob Westgeest
image: /attachments/blogposts/2016/baunit.png
---

This is the second part of my writeup of the session I did at [XPDays Benelux](http://www.xpday.net/Xpday2015/FrontPage.html) and [XP 2016](http://xp2016.org) in
Edinburgh called "Bourne Again" on bootstrapping a unit testing framework
in the Bourne Again Shell (bash). This series of posts walk you through the
steps I took in 75 minutes of programming.

This series consist of the following episodes.

* [Part one - Running tests](/2016/05/28/baunit-part-one.html)
* Part two - Asserts
* Part three - Reporting

I may write more parts, while rehearsing for the session, I tried, among
others:

* run multiple modules in a tree
* setup and teardown

## Part two - Asserts

In part one I ended with these tests, testing the basic behaviour of the
test framework :

~~~bash
# tests/runner_tests.sh
test_runner_runs_tests_in_module() {
  [[ "first_run second_run" == $(a_single_line_log_of a_test_run_of a_module_with_2_tests ) ]]
}
test_runner_runs_all_tests_even_if_one_fails() {
  [[ "first_run second_run" == $(a_single_line_log_of a_test_run_of a_module_with_2_tests_where_one_fails) ]]
}
test_runner_returns_one_on_failure() {
  [[ 1 == $(a_silent_run_of a_test_run_of a_module_with_2_tests_where_one_fails)$? ]]
}
test_runner_returns_zero_on_success() {
  [[ 0 == $(a_silent_run_of a_test_run_of a_module_with_2_tests)$? ]]
}
~~~

And the implementation:

~~~bash
# run_tests.sh
run_tests() {
  local test_module=$1
  source $test_module
  local module_result=0
  for test in $(tests_in $test_module)
  do
    ( $test )
    (( module_result = module_result || $? ))
  done
  return 1
  return $module_result
}
tests_in() {
  local test_module=$1
}
run_tests tests/runner_tests.sh
~~~

The test look all right, but the asserts are a bit odd, they really are
bash style tests and look like boolean expressions really. Apart from
their look, that can be improved, they show no useful message at all
when failing.

Up until now the feedback was good enough, as each
individual new test was failing first, and I had a clear expectation of
_what_ was failing. An unexpected failing test will leave you guessing
and debugging on where the actual failure is.

### assert_equals gives feedback

The goal is to get some feedback from the asserts in the form of en
error message that shows what went wrong. Well leave adding context
(which test failed) out of scope.

We'll put the tests for assert_equals in a new test module. Since *run_tests* can
only run a suite of tests in one module  (file), we'll have to add a
*run_tests* line to the end of the line as shown below and touch
*tests/assertion_testss.sh*:

~~~bash
run_tests tests/runner_tests.sh &&
  run_tests tests/assertion_tests.sh
~~~

As a first test, we'll test textual output if an assert fails. I tried
both ways (starting with exit codes and starting with textual output,
and the latter gave less problems, as the feedback is richer when some
test fails. More importantly, it gave me less problems in stumbling on
peculiarities of the bash language.

~~~bash
# tests/assertion_tests.sh
test_assert_equals_shows_message_on_error() {
  [[ "Assertion failed; expected '0', but was: '1'" == $(assert_equals 0 1)  ]]
}
~~~

We'll write the implementation in the test file itself, almost in a ['as
if you really meant it'](https://cumulative-hypotheses.org/2011/08/30/tdd-as-if-you-meant-it/) style. We'll fake it like so:

~~~bash
assert_equals() {
  echo "Assertion failed; expected '0', but was: '1'"
}
~~~

It is not _really_ faking, we just have no reason to do anything more
complicated than this yet. We could write an extra tests, as we prefer
tests to have only one assert, but in the session, I was lazy, under
time pressure, had some whiskey the other night and, if I think hard, I
can come up with more excuses.

No really. It is a balance between having each test testing one concern and
each test testing one situation (one case). In some cases, I even regard
the previous test and its implementation as duplication and 'refactor'
that away by changing the implementation to use the parameters in the
message, leaving the test alone.

In the session, I added an assert to the existing test,

~~~bash
test_assert_equals_shows_message_on_error() {
  [[ "Assertion failed; expected '0', but was: '1'" == $(assert_equals 0 1)  ]]
  [[ "Assertion failed; expected '1', but was: '2'" == $(assert_equals 1 2)  ]]
}
~~~

and adapted the implementation to make it pass again, I'll save you the separate
refactoring step, where I changed *$1* to *$expected* and so on:

~~~bash
assert_equals() {
  local expected=$1
  local actual=$2
  echo "Assertion failed; expected '$expected', but was: '$actual'"
}
~~~

Next, a succesful *assert_equals* should
show no output at all:

~~~bash
test_assert_equals_shows_nothing_on_success() {
  [[ "" == $(assert_equals 1 1)  ]]
}
~~~

Now the implementation needs an  *if* statement.

~~~bash
assert_equals() {
  local expected=$1
  local actual=$2
  if [[ $expected != $actual ]]
  then
    echo "Assertion failed; expected '$expected', but was: '$actual'"
  fi
}
~~~

### assert_equals returns a value indicating success or failure

To make *assert_equals* usable, it'll have to return a value indicating
its success (non zero for failure and zero for success). For the return value we start with a failing *assert_equals* again. Try
with a successful one and you'll find it hard to write a failing test.

We'll use the *silent_run_of* function from part one focus on the return
value rather than the failure message.

~~~bash
test_assert_equals_returns_1_on_error() {
  [[ 1 == $(a_silent_run_of assert_equals 0 1)$? ]]
}
~~~

The implementation is simple, We'll fake it to always return '1'.

~~~bash
assert_equals() {
  local expected=$1
  local actual=$2
  if [[ $expected != $actual ]]
  then
    echo "Assertion failed; expected '$expected', but was: '$actual'"
  fi
  return 1
}
~~~

Next test is to return 0 for a successful test.

~~~bash
test_assert_equals_returns_0_on_success() {
  [[ 0 == $(a_silent_run_of assert_equals 0 0)$? ]]
}
~~~

In the implementation, we'll just have to move *return 1* up one line.

~~~bash
assert_equals() {
  local expected=$1
  local actual=$2
  if [[ $expected != $actual ]]
  then
    echo "Assertion failed; expected '$expected', but was: '$actual'"
    return 1
  fi
}
~~~

This is not quite what we want though. We'll want a failing assert to
exit the test, as if it throws an exception. Remember from 
[Part one - Running tests](/2016/05/28/baunit-part-one.html) that the
runner, can cope with exiting tests. It'll run the next test
regardless.

So how to test *assert_equals*' exit? Well, if we would call a subsshell
with a failing *assert_equals*, and a *return 0* statement. It should
return 1:

~~~bash
test_assert_equals_exits_on_error() {
  [[ 1 == $(a_silent_run_of assert_equals 0 1; return 0)$? ]]
}
~~~

And, yes! The test fails, it returns 0 not 1. Implementation is to
replace return by exit:

~~~bash
assert_equals() {
  local expected=$1
  local actual=$2
  if [[ $expected != $actual ]]
  then
    echo "Assertion failed; expected '$expected', but was: '$actual'"
    exit 1
  fi
}
~~~

### Result of part 2

Now our *assert_equals* is ready for use. We'll move it to
*run_tests.sh*, and replace the assertions in the current current test
module (one by one of course - baby steps). The assertion_tests file looks like:

~~~bash
# tests/assertion_tests.sh
test_assert_equals_shows_message_on_error() {
  assert_equals "Assertion failed; expected '0', but was: '1'" "$(assert_equals 0 1)"
  assert_equals "Assertion failed; expected '1', but was: '2'" "$(assert_equals 1 2)"
}
test_assert_equals_returns_1_on_error() {
  assert_equals 1 "$(a_silent_run_of assert_equals 0 1)$?"
}
test_assert_equals_exits_on_error() {
  assert_equals 1 "$(a_silent_run_of assert_equals 0 1; return 0)$?"
}
test_assert_equals_shows_nothing_on_success() {
  assert_equals "" "$(assert_equals 1 1)"
}
test_assert_equals_returns_0_on_success() {
  assert_equals 0 "$(a_silent_run_of assert_equals 0 0)$?"
}
~~~

After replacing the boolean expressions in the runner_tests, it looks
like:

~~~bash
# tests/runner_tests.sh
test_runner_runs_tests_in_module() {
  assert_equals "first_run second_run" "$(a_single_line_log_of a_test_run_of a_module_with_2_tests )"
}
test_runner_runs_all_tests_even_if_one_fails() {
  assert_equals "first_run second_run" "$(a_single_line_log_of a_test_run_of a_module_with_2_tests_where_one_fails)"
}
test_runner_returns_one_on_failure() {
  assert_equals 1 "$(a_silent_run_of a_test_run_of a_module_with_2_tests_where_one_fails)$?"
}
test_runner_returns_zero_on_success() {
  assert_equals 0 "$(a_silent_run_of a_test_run_of a_module_with_2_tests)$?"
}
~~~

And the implementation *run_tests.sh* looks like:

~~~bash
# run_tests.sh
run_tests() {
  local test_module=$1
  source $test_module
  local module_result=0
  for test in $(tests_in $test_module)
  do
    ( $test )
    (( module_result = module_result || $? ))
  done
  return 1
  return $module_result
}
tests_in() {
  local test_module=$1
}
run_tests tests/runner_tests.sh &&
  run_tests tests/assertion_tests.sh

~~~

A neat little test framework with lots to improve.
