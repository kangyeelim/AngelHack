## Changelog for `hoe-debugging`

### 2.0.0 / 2018-11-04

Features:

* Allow multiple suppression files to be active at once. Pull in all
  suppression files that match a part of the ruby version. Along with
  this change, the helper method `matching_suppression_file` is
  renamed to `matching_suppression_files`.


### 1.5.0 / 2018-11-02

Features:

* Suppression metadata is always logged when warnings are generated
* Rake task `valgrind:suppression` can generate a suppression file from a previous run's log file. Great for when CI finds things that are hard to reproduce!


### 1.4.2 / 2017-06-19

Features:

* Allow matching suppression file on major Ruby version.


### 1.4.1 / 2017-06-19

Features:

* Support frozen string constants.


### 1.4.0 / 2017-06-19

Features:

* Add explanatory messages to suppression file generation.


Bugfixes:

* Fixed generation of suppression files.


### 1.3.0 / 2017-01-20

* The rake task now fails if valgrind detects any errors during the run.


### 1.2.1 / 2015-12-16

Features:

* Set larger stack size (via `ulimit -s`) to properly support Ruby 2.1 and later


### 1.2.0 / 2015-01-22

Features:

* Ruby 2.2 support.


Bugfixes:

* Replace references to `Config` with `RbConfig`, for Ruby 2.2 support.


### 1.1.1 / 2012-11-26

Bugfixes:

* Correctly name suppression files for REE.


### 1.1.0 / 2012-09-26

* Valgrind suppressions can be generated with `rake test:valgrind:suppression`
* If present, valgrind suppressions will be used when valgrinding.

### 1.0.5 / 2012-06-19

* RSpec support now works with TESTOPTS.

### 1.0.4 / 2012-06-19

* Adding support for RSpec.

### 1.0.3 / 2012-02-06

* Fixing compatibility with latter-day versions of rake. #1

### 1.0.2 / 2011-11-13

* Fixing reference to ::RUBY with rbconfig-based construction of the ruby interpreter path.

### 1.0.1 / 2009-06-26

* Fix Hoe dependency version.
* Activate the hoe-git plugin.
* Fix docs, give Mike some well-deserved credit!

### 1.0.0 / 2009-06-22

* Birthday!
