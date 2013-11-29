# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','invoicerb','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'invoicerb'
  s.version = Invoicerb::VERSION
  s.author = 'B. F. B. Emson'
  s.email = 'mail@emson.co.uk'
  s.homepage = 'http://blog.emson.co.uk'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Invoicerb: Simple commandline invoicing'
  s.description = %q{A command line tool that makes it very easy to create invoices. }

  # specify the files in your application
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths << 'lib'
  s.bindir = 'bin'

  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md','invoicerb.rdoc']
  s.rdoc_options << '--title' << 'invoicerb' << '--main' << 'README.rdoc' << '-ri'

  s.executables << 'invoice'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('rspec')
  s.add_development_dependency('aruba')

  s.add_runtime_dependency('mustache')
  s.add_runtime_dependency('gli','2.8.1')
  s.add_runtime_dependency('prawn', '~>1.0.0.rc1')
end

