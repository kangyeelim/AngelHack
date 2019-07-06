##
# Signing plugin for hoe.
#
# === Tasks Provided:
#
# generate_key::       Generate a key for signing your gems.
#
# === Extra Configuration Options:
#
# signing_key_file::    Signs your gems with this private key.
# signing_cert_file::   Signs your gem with this certificate.
#
# === Usage:
#
# Run the 'generate_key' task.  This will:
#
# 1. Configure your ~/.hoerc.
# 2. Generate a signing key and certificate.
# 3. Install the private key and public certificate files into ~/.gem.
#
# Hoe will now generate signed gems when the package task is run.  If you have
# multiple machines you build gems on, be sure to install your key and
# certificate on each machine.
#
# Keep your private key secret!  Keep your private key safe!
#
# To make sure your gems are signed run:
#
#   rake package; tar tf pkg/yourproject-1.2.3.gem
#
# If your gem is signed you will see:
#
#   data.tar.gz
#   data.tar.gz.sig
#   metadata.gz
#   metadata.gz.sig

module Hoe::Signing
  Hoe::DEFAULT_CONFIG["signing_key_file"]  = "~/.gem/gem-private_key.pem"
  Hoe::DEFAULT_CONFIG["signing_cert_file"] = "~/.gem/gem-public_cert.pem"

  ##
  # Define tasks for plugin.

  def define_signing_tasks
    set_up_signing

    desc "Generate a key for signing your gems."
    task :generate_key do
      generate_key_task
    end

    desc "Check pubilc key for signing your gems."
    task :check_key do
      check_key_task
    end
  end

  def set_up_signing # :nodoc:
    signing_key = nil
    cert_chain = []

    with_config do |config, _path|
      break unless config["signing_key_file"] and config["signing_cert_file"]
      key_file = File.expand_path config["signing_key_file"].to_s
      signing_key = key_file if File.exist? key_file

      cert_file = File.expand_path config["signing_cert_file"].to_s
      cert_chain << cert_file if File.exist? cert_file
    end

    if signing_key and cert_chain then
      spec.signing_key = OpenSSL::PKey::RSA.new File.read signing_key
      spec.cert_chain = cert_chain
    end
  end

  def check_key_task # :nodoc:
    with_config do |config, _path|
      break unless config["signing_cert_file"]
      pub_key = File.expand_path config["signing_cert_file"].to_s

      c = OpenSSL::X509::Certificate.new File.read pub_key
      t = c.not_after

      if t < Time.now then
        warn "Gem signing certificate has expired"
      else
        warn "Gem signing certificate has NOT expired. Carry on."
      end
    end
  end

  def generate_key_task # :nodoc:
    email = Array(spec.email)
    abort "No email in your gemspec" if email.nil? or email.empty?

    key_file = with_config { |config, _| config["signing_key_file"] }
    cert_file = with_config { |config, _| config["signing_cert_file"] }

    if key_file.nil? or cert_file.nil? then
      ENV["SHOW_EDITOR"] ||= "no"
      Rake::Task["config_hoe"].invoke

      key_file = with_config { |config, _| config["signing_key_file"] }
      cert_file = with_config { |config, _| config["signing_cert_file"] }
    end

    key_file = File.expand_path key_file
    cert_file = File.expand_path cert_file

    unless File.exist? key_file then
      puts "Generating certificate"

      if File.exist? key_file then
        abort "Have #{key_file} but no #{cert_file}, aborting as a precaution"
      end

      warn "NOTICE: using #{email.first} for certificate" if email.size > 1

      sh "gem cert --build #{email.first}"
      mv "gem-private_key.pem", key_file, :verbose => true
      mv "gem-public_cert.pem", cert_file, :verbose => true

      puts "Installed key and certificate."
    end

    puts "Key file = #{key_file}"
    puts "Cert file = #{cert_file}"
    puts
    puts "Until rubygems.org has a better strategy for signing, that's"
    puts "the best we can do at this point."
  end
end
