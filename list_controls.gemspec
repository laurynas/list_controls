$: << File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'list_controls'
  s.version      = '0.1.3'
  s.authors      = ['Laurynas Butkus']
  s.email        = 'laurynas.butkus@gmail.com'
  s.homepage     = 'http://github.com/laurynas/list_controls'
  s.summary      = 'Simple list filtering & sorting for Rails controller'
  s.description  = "#{s.summary}."

  s.files        = Dir['{lib/**/*,[A-Z]*}']
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
  
  s.add_development_dependency 'ruby-debug'
end
