require "shellwords"
require "rbconfig"
require "rake/tasklib"

module Minitest # :nodoc:

  ##
  # Minitest::TestTask is a rake helper that generates several rake
  # tasks under the main test task's name-space.
  #
  #   task <name>      :: the main test task
  #   task <name>:cmd  :: prints the command to use
  #   task <name>:deps :: runs each test file by itself to find dependency errors
  #   task <name>:slow :: runs the tests and reports the slowest 25 tests.
  #
  # Examples:
  #
  #   Minitest::TestTask.create
  #
  # The most basic and default setup.
  #
  #   Minitest::TestTask.create :do_the_thing
  #
  # The most basic/default setup, but with a custom name
  #
  #   Minitest::TestTask.create :spec do |t|
  #     t.test_globs = ["spec/**/*_spec.rb"]
  #     t.libs << "../dependency/lib"
  #   end
  #
  # Customize the name, dependencies, and use a spec directory instead
  # of test.

  class TestTask < Rake::TaskLib
    WINDOWS = RbConfig::CONFIG["host_os"] =~ /mswin|mingw/ # :nodoc: # TODO: verify

    ##
    # Create several test-oriented tasks under +name+. Takes an
    # optional block to customize variables.

    def self.create name = :test, &block
      task = new name
      task.instance_eval(&block) if block
      task.process_env
      task.define
      task
    end

    ##
    # Extra arguments to pass to the tests. Defaults empty but gets
    # populated by a number of enviroment variables:
    #
    # + N (-n flag) a string or regexp of tests to run.
    # + X (-e flag) a string or regexp of tests to exclude.
    # + TESTOPTS - extra stuff. For compatibility? I guess?
    # + A (arg) - quick way to inject an arbitrary argument (eg A=--help)

    attr_accessor :extra_args

    ##
    # The code to load the framework. Defaults to requiring
    # minitest/autorun...
    #
    # Why do I have this as an option?

    attr_accessor :framework

    ##
    # Extra library directories to include. Defaults to %w[lib test
    # .]. Also uses $MT_LIB_EXTRAS allowing you to dynamically
    # override/inject directories for custom runs.

    attr_accessor :libs

    ##
    # The name of the task and base name for the other tasks generated.

    attr_accessor :name

    ##
    # File globs to find test files. Defaults to something sensible to
    # find test files under the test directory.

    attr_accessor :test_globs

    ##
    # Turn on ruby warnings (-w flag). Defaults to true.

    attr_accessor :warning

    ##
    # Optional: Additional ruby to run before the test framework is loaded.

    attr_accessor :test_prelude

    ##
    # Print out commands as they run. Defaults to Rake's trace (-t
    # flag) option.

    attr_accessor :verbose

    def initialize name = :test # :nodoc:
      self.extra_args   = []
      self.framework    = %(require "minitest/autorun")
      self.libs         = %w[lib test .]
      self.name         = name
      self.test_globs   = ["test/**/{test,spec}_*.rb",
                           "test/**/*_{test,spec}.rb"]
      self.test_prelude = nil
      self.verbose      = Rake.application.options.trace
      self.warning      = true
    end

    ##
    # Extract variables from the environment and convert them to
    # command line arguments. See +extra_args+.
    #
    # Environment Variables:
    #
    # + MT_LIB_EXTRAS - Extra libs to dynamically override/inject for custom runs.
    # + N             - Tests to run (string or regexp)
    # + X             - Tests to exclude (string or regexp)
    # + TESTOPTS      - deprecated, use A
    # + A             - Any extra arguments. Honors shell quoting.

    def process_env
      warn "TESTOPTS is deprecated in Minitest::TestTask. Use A instead" if
        ENV["TESTOPTS"]

      lib_extras = (ENV["MT_LIB_EXTRAS"] || "").split File::PATH_SEPARATOR
      self.libs.prepend lib_extras

      extra_args << "-n" << ENV["N"]                      if ENV["N"]
      extra_args << "-e" << ENV["X"]                      if ENV["X"]
      extra_args.concat Shellwords.split(ENV["TESTOPTS"]) if ENV["TESTOPTS"]
      extra_args.concat Shellwords.split(ENV["A"])        if ENV["A"]

      # TODO? RUBY_DEBUG = ENV["RUBY_DEBUG"]
      # TODO? ENV["RUBY_FLAGS"]

      extra_args.compact!
    end

    ##
    # Create the tasks.

    def define
      default_tasks = []

      desc "Run the test suite. Use N, X, A, and TESTOPTS to add flags/args."
      task name do
        ruby make_test_cmd, verbose:verbose
      end

      desc "Print out the test command. Good for profiling and other tools."
      task "#{name}:cmd" do
        puts "ruby #{make_test_cmd}"
      end

      desc "Show which test files fail when run alone."
      task "#{name}:deps" do
        tests = Dir[*self.test_globs].uniq

        null_dev = WINDOWS ? "> NUL 2>&1" : "> /dev/null 2>&1"

        tests.each do |test|
          cmd = make_test_cmd test

          if system "ruby #{cmd} #{null_dev}" then
            puts "# good: #{test}"
          else
            puts "# bad: #{test}"
            puts "  ruby #{cmd}"
          end
        end
      end

      desc "Show bottom 25 tests wrt time."
      task "#{name}:slow" do
        sh ["rake #{name} TESTOPTS=-v",
            "egrep '#test_.* s = .'",
            "sort -n -k2 -t=",
            "tail -25"].join " | "
      end

      default_tasks << name

      desc "Run the default task(s)."
      task :default => default_tasks
    end

    ##
    # Generate the test command-line.

    def make_test_cmd globs = test_globs
      tests = []
      tests.concat Dir[*globs].shuffle
      tests.map! { |f| %(require "#{f}") }

      runner = []
      runner << framework
      runner << test_prelude if test_prelude
      runner.concat tests
      runner = runner.join "; "

      args  = []
      args << "-I#{libs.join(File::PATH_SEPARATOR)}" unless libs.empty?
      args << "-w" if warning
      args << '-e'
      args << "'#{runner}'"
      args << '--'
      args << extra_args.map(&:shellescape)

      args.join " "
    end
  end
end
