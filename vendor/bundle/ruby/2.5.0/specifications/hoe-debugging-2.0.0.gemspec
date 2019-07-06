# -*- encoding: utf-8 -*-
# stub: hoe-debugging 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hoe-debugging".freeze
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Barnette".freeze, "Mike Dalessio".freeze]
  s.date = "2018-11-04"
  s.description = "A Hoe plugin to help you debug your C extensions. This plugin provides `test:gdb` and `test:valgrind` tasks (plus a few variants). As of v1.5 it also can generate a valgrind suppression from a previous test suite's log file.\n\nSee the `Hoe::Debugging` module for a few configuration options.\n\nThis plugin expects you to have `gdb` and `valgrind` available in your `PATH`.".freeze
  s.email = ["jbarnette@rubyforge.org".freeze, "mike.dalessio@gmail.com".freeze]
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "Manifest.txt".freeze, "README.md".freeze]
  s.files = ["CHANGELOG.md".freeze, "Manifest.txt".freeze, "README.md".freeze]
  s.homepage = "http://github.com/jbarnette/hoe-debugging".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "A Hoe plugin to help you debug your C extensions".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_development_dependency(%q<hoe>.freeze, ["~> 3.1"])
      s.add_development_dependency(%q<hoe-bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<hoe-gemspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<hoe-git>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake-compiler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_development_dependency(%q<concourse>.freeze, ["~> 0.1"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 4.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_dependency(%q<hoe>.freeze, ["~> 3.1"])
      s.add_dependency(%q<hoe-bundler>.freeze, [">= 0"])
      s.add_dependency(%q<hoe-gemspec>.freeze, [">= 0"])
      s.add_dependency(%q<hoe-git>.freeze, [">= 0"])
      s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_dependency(%q<concourse>.freeze, ["~> 0.1"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 4.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_dependency(%q<hoe>.freeze, ["~> 3.1"])
    s.add_dependency(%q<hoe-bundler>.freeze, [">= 0"])
    s.add_dependency(%q<hoe-gemspec>.freeze, [">= 0"])
    s.add_dependency(%q<hoe-git>.freeze, [">= 0"])
    s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<concourse>.freeze, ["~> 0.1"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 4.0"])
  end
end
