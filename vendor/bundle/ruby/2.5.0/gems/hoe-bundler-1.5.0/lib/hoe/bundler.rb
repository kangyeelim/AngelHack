class Hoe #:nodoc:
  #
  #  Rake task to generate a bundler Gemfile based on your declared hoe dependencies.
  #
  #  * <tt>bundler:gemfile</tt>
  #  * <tt>bundler:gemfile[https://rubygems.org/,false]</tt>
  #
  module Bundler
    VERSION = "1.5.0" #:nodoc:

    DEFAULT_SOURCE = 'https://rubygems.org/'
    DEFAULT_USE_GEMSPEC = false

    def define_bundler_tasks
      desc "generate a bundler Gemfile from your Hoe.spec dependencies"
      task "bundler:gemfile", :source, :use_gemspec do |t,args|
        args.with_defaults(:source => DEFAULT_SOURCE, :use_gemspec => DEFAULT_USE_GEMSPEC)
        File.open("Gemfile","w") do |gemfile|
          gemfile.print hoe_bundler_contents(args)
        end
      end
    end

    def hoe_bundler_contents(args = {})
      args[:source] = DEFAULT_SOURCE unless args.has_key?(:source)
      args[:use_gemspec] = DEFAULT_USE_GEMSPEC unless args.has_key?(:use_gemspec)

      gemfile = StringIO.new
      gemfile.puts "# -*- ruby -*-"
      gemfile.puts
      gemfile.puts "# DO NOT EDIT THIS FILE. Instead, edit Rakefile, and run `rake bundler:gemfile`."
      gemfile.puts
      gemfile.puts "source "<< ((args[:source] =~ /^https?:\/\//) ? "\"#{args[:source]}\"" : ":#{args[:source]}")
      gemfile.puts "gemspec" if args[:use_gemspec]
      gemfile.puts

      unless args[:use_gemspec]
        hoe_bundler_add_dependencies(self.extra_deps, gemfile)
        hoe_bundler_add_dependencies(self.extra_dev_deps, gemfile, ", :group => [:development, :test]")
      end

      gemfile.puts "# vim: syntax=ruby"

      gemfile.rewind
      gemfile.read
    end

    def hoe_bundler_add_dependencies(deps, gemfile, postfix=nil)
      deps2 = {}
      deps.each do |name, version|
        version ||= ">=0"
        deps2[name] = version unless deps2.key?(name)
      end
      deps2.each do |name, version|
        output = [%Q{gem "#{name}"}]
        Array(version).each do |ver|
          output << %Q{"#{ver.gsub(/ /,'')}"}
        end
        gemfile.puts %Q{#{output.join(", ")}#{postfix}}
      end
      gemfile.puts
    end
  end
end