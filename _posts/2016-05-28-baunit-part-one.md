---
layout: post
title:  Test Drive a unit testing framework in bash part one
author: Rob Westgeest
image: /attachments/blogposts/2016/baunit.png
---

I did a public programming session at [XPDays Benelux](http://www.xpday.net/Xpday2015/FrontPage.html) and [XP 2016](http://xp2016.org) in
Edinburgh called "Bourne Again" on bootstrapping a unit testing framework
in the Bourne Again Shell (bash). This series of posts walk you through the
steps I took in 75 minutes of programming.

This series consist of the following episodes.

* Part one - Running tests
* Part two - Asserts
* Part three - Reporting

I may write more parts, while rehearsing for the session, I did, among
others:

* run multiple modules in a tree
* setup and teardown

## Part one - Running tests

### Why Bash ?

Choosing a language for automating small build tasks feels like choosing a problem. For scripting languages like python and ruby you end up learning and polluting your machine with pip, virtualenv, chruby, rubygems and the like. And while bash is always around, it simply is not powerful enough!

Or is it? Am I just overly anxious about doing anything serious in bash? Do I just need a bit of courage to try and express intent in this awkward, inconsequent odd language? 

I wanted to learn more about bash as a scripting language. Therefore I decided to bootstrap a test framework, as it is a great way to learn or explore a programming language in baby steps. 

### The code and video

You can find the code of this series of posts on
[github:rwestgeest/baunit2016](https://github.com/rwestgeest/baunit-xp2016) and I am planning to publish a screen cast as well. You find the link here when that's available.

### Tasks list

This post is about the first task. Which is really split up into:

* Run tests in a module
* Failure should not skip tests
* 0 on success, 1 on failure

If we can do that, we can use it to organize our tests.

### Getting set up

We start with a script that should eventually be able to run tests. I
call it *run_tests.sh*. It is empty for now, but executable. I split my
terminal in three (using iTerm); one in which I have the editor open,
one in which the tests continuously run to get rich feedback, and one
for doing git commits.

The testing terminal runs a simple one-liner script: 

~~~bash
  while true; do clear; ./run_tests.sh && echo Success || echo Failed; sleep 2; done
~~~

This is a simple and effective way to continously run the tests, as long
as it does not take too long to run. It shows _Success_ continuously, since my *run_tests.sh* is empty. An
empty script seems successful. And, since I want to do git commits fast and easy in the session, I run
the following one-liner in the git terminal:

~~~bash
  while true; do read -p "next commit : " commit_msg && git add . && git commit -m "$commit_msg"; done
~~~

### Run tests in a module

Lets see how we can make a first failing tests. A simple comparison of
'0' and '1' does the trick.

~~~bash
#!/bin/sh

[[ 0 == 1 ]]
~~~

Indeed shows 'Failed', so this is a simple way to write assertions. The first thing we want
do do for real, is write a function called *run_tests* (named after the
script itself) that runs a test function. So my failing test looks like:


~~~bash
test_first() {
  echo was_run
}

[[ "was_run" == $(run_tests) ]]
~~~

This fails, because there is no *run_tests* yet. So lets add it:

~~~bash
test_first() {
  echo was_run
}
run_tests() {
  return 0
}
[[ "was_run" == $(run_tests) ]]
~~~

It still fails, but for another reason. *run_tests* exists. It just  doesn't 
do anything useful. So we'll fake its behaviour by doing:

~~~bash
run_tests() {
  echo was_run
}
~~~

Success!! It is passing. Not for the right reason, but it's a baby step
to keep us going. Now I'll implement it correctly and keep my eye on the
test output:

~~~bash
run_tests() {
  test_first
}
~~~

It's still successful. All code (test and implementation remains in the same
file *run_tests.sh* for now. Will work on that later. One runnable test
is nice, but we want to be able to run multiple tests in a module. Taking the 0, 1, many
principle, I trust that *run_tests* can run many tests in a module if it can run two.

My next test would be:

~~~bash
test_first() {
  echo was_run
  echo first_run
}
test_second() {
  echo second_run
}
# ....
[[ "first_run second_run" == $(run_tests) ]]
~~~

We extend the current test, since the first and second sort
of contradict each other. One expects *run_tests* to run one test,
the other expects it to run two of them.

Making int pass is easy:

~~~bash
run_tests() {
  test_first
  test_second
}
~~~

Or is it? Testing terminal still tells me _"Failed"_. Fascinating! What
is wrong. It appears that _echo_ appends a newline on stdout. Which makes the
test compare *"first_run second_run"* with *"first_run"* even though the
implementation is correct. There is a simple fix for this though. Piping
the output of *run_tests* through *xargs* makes all newlines disappear. So
the test should change to:

~~~bash
[[ "first_run second_run" == $(run_tests | xargs) ]]
~~~

Success!!, Tests are green again! Now there is still a problem with
this. *run_test* quite specifically runs *test_first* and *test_second*,
We'd like that more generalized, like "all test functions in a module".
This should be possible by _grep_ping all *test_* functions in the module.

~~~bash
run_tests() {
  for test in $(grep ^test\_ $)
  do
    $test
  done
}
~~~

Oops, that fails the test. It seems it tries to call *test_function()
{*, where it should just call *test_function*. *Sed* enables us to strip
the characters we don't want (as does _tr_. There are so many choices
;-)).

~~~bash
run_tests() {
  for test in $( grep ^test_ $test_module | sed -e 's/[() {]//g' )
  do
    $test
  done
}
~~~

And jay! It's ugly, but it works. The result can be brought to the right
level of abstraction and expressing intent by:

~~~bash
# ....
run_tests() {
  for test in $(tests_in $0)
  do
    $test
  done
}
tests_in() {
  local test_module=$1
  grep ^test_ $test_module | sed -e 's/[() {]//g'
}
[[ "first_run second_run" == $(run_tests | xargs) ]]
~~~

And we can parameterize *run_tests* so that we're prepared to move the
test functions to their own module and build new tests based on different
test modules. We need that for the next task on failing tests.

~~~bash
# ....
run_tests() {
  local test_module=$1
  for test in $(tests_in $test_module)
# ....
[[ "first_run second_run" == $(run_tests $0 | xargs) ]]
~~~

Now we can move the *test_* functions to their own module and use that
in our test.

~~~bash
# data/a_module_with_2_tests.sh
test_first() {
  echo first_run
}
test_second() {
  echo second_run
}
~~~

~~~bash
# run_tests.sh
run_tests() {
  local test_module=$1
  source $test_module
  for test in $(tests_in $test_module)
  do
    $test
  done
}
tests_in() {
  local test_module=$1
  grep ^test_ $test_module | sed -e 's/[() {]//g'
}
[[ "first_run second_run" == $(run_tests data/a_module_with_2_tests.sh | xargs) ]]
~~~

### Failure should not skip tests

We're ready to add more tests. The first one, tests that all tests
are run even if one fails. So:

~~~bash
# run_tests.sh
# ...
[[ "first_run second_run" == $(run_tests data/a_module_with_2_tests.sh | xargs) ]] &&
[[ "first_run second_run" == $(run_tests data/a_module_with_2_tests_where_one_fails.sh | xargs) ]]
~~~

~~~bash
# data/a_module_with_2_tests_where_one_fails.sh
test_first() {
  echo first_run
  exit 1
}
test_second() {
  echo second_run
}
~~~
As expected, our test fails. The second test is not run because the
first one exits the shell that runs the test. Note that it does'nt exit
the script. It exits the subshell *$(run_tests ....)* and therefore the
for loop.

Making it pass is quite easy, Just make sure the test is run in it's own
subshell. The failing one will exit that subshell but not the for loop.


~~~bash
#run_tests.sh
run_tests() {
  local test_module=$1
  source $test_module
  for test in $(tests_in $test_module)
  do
    ( $test )
  done
}
# tests_in ....
[[ "first_run second_run" == $(run_tests data/a_module_with_2_tests.sh | xargs) ]] &&
[[ "first_run second_run" == $(run_tests data/a_module_with_2_tests_where_one_fails.sh | xargs) ]]
~~~

Ok that works. As soon as *run_tests* returns a value telling us that the
test module succeeded or failed, it is actually usable. But first lets
do some refactoring. There is some duplicated detail that does not
reveal our intent. The expressions that run a test show a detailed path
for the module, which is not that relevant (data/...sh) and they use
xargs to make the produced log a single line log. Let's start with the
latter, and see if we can express more what we want:

~~~bash
a_single_line_log_of() {
  $@ | xargs
}
[[ "first_run second_run" == $(a_single_line_log_of run_tests data/a_module_with_2_tests.sh ) ]] &&
[[ "first_run second_run" == $(a_single_line_log_of run_tests data/a_module_with_2_tests_where_one_fails.sh ) ]]
~~~

Neat! *$@* means all arguments except the first (which is the function
itself). So the call expresses intent, as well as the implementation
using '| xargs'.

Now I am still bothered with the noise that *data/* and *.sh* produces.
We can change that to:

~~~bash
a_single_line_log_of() {
  $@ | xargs
}
a_test_run_of() {
  local test_module=$1
  run_tests data/$test_module.sh
}
[[ "first_run second_run" == $(a_single_line_log_of a_test_run_of a_module_with_2_tests) ]] &&
[[ "first_run second_run" == $(a_single_line_log_of a_test_run_of a_module_with_2_tests_where_one_fails) ]]
~~~
Nice! This is where I observed that you can actually produce something
readable in bash. It almost reads like a sentence.

### 0 on success, 1 on failure

On to the return values. Making a test that fails we need to start with
the failing module case. run_tests will return 0 by default, So a test
where we expect 1 to return should fail. Here it is:

~~~bash
a_silent_run_of() {
  $@ > /dev/null
}
[[ 1 == $(a_silent_run_of a_test_run_of a_module_with_2_tests_where_one_fails)$? ]]
~~~

There are two things noteworthy. First *a_silent_run_of* is added so
that 1 is not compared to the log output of the tests.
(*a_silent_run_of* would normally be extracted afterwards, but I was in
a hurry in the session). Second: *$(..)$?* results in the exit code of
the subshell and therefore the return value of run_tests.

The test fails, and we can easily make it pass by always returning 1 in
run_tests.sh

~~~bash
run_tests() {
  local test_module=$1
  source $test_module
  for test in $(tests_in $test_module)
  do
    ( $test )
  done
  return 1
}
~~~

Lets triangulate this out by writing another case where we expect it to
return 0 on success:

~~~bash
[[ 0 == $(a_silent_run_of a_test_run_of a_module_with_2_tests)$? ]]
~~~

And make it green by tracking the return values of the tests. We'll
learn something new in bash as well.

~~~bash
run_tests() {
  local test_module=$1
  source $test_module
  local module_result=0
  for test in $(tests_in $test_module)
  do
    ( $test )
    (( module_result = module_result || $? ))
  done
  return $module_result
}
~~~

And green again! It appears that we can do logic and arithmetic expressions using the
double bracket notation *(( ))*. It is a bit of a silly notation but it
works. 

Now, the test framework is good enough to move our tests to their own
test module. To do that we run a new test module and move the tests in
there one by one.

First we add a call to running the new test module and add an emty one (baby steps).
Then we move the test one by one to the module. Moving the first
test would look like:

~~~bash
# tests/runner_tests.sh
test_runner_runs_tests_in_module() {
  [[ "first_run second_run" == $(a_single_line_log_of a_test_run_of a_module_with_2_tests ) ]]
}
~~~

~~~bash
# run_tests.sh
# ...
[[ "first_run second_run" == $(a_single_line_log_of a_test_run_of a_module_with_2_tests_where_one_fails) ]] &&
[[ 1 == $(a_silent_run_of a_test_run_of a_module_with_2_tests_where_one_fails)$? ]] &&
[[ 0 == $(a_silent_run_of a_test_run_of a_module_with_2_tests)$? ]]
run_tests tests/runner_tests.sh
~~~

After moving the all tests the end result is:

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
