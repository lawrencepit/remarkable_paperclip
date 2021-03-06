require 'paperclip/extension'
require 'matchers/have_attached_file_matcher'
require 'matchers/validate_attachment_size_matcher'
require 'matchers/validate_attachment_presence_matcher'
require 'matchers/allow_attachment_content_type_for_matcher'

if defined?(Spec::Rails)
  Remarkable.include_matchers!(Remarkable::Paperclip, Spec::Rails::Example::ModelExampleGroup)
else
  Remarkable.include_matchers!(Remarkable::Paperclip, Spec::Example::ExampleGroup)
end

Remarkable.add_locale(File.dirname(__FILE__) + '/../locale/en.yml')
