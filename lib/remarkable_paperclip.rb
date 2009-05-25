require 'have_attached_file_matcher'
require 'validate_attachment_size_matcher'
require 'validate_attachment_presence_matcher'
require 'validate_attachment_content_type_matcher'

Remarkable.include_matchers!(Remarkable::Paperclip, Spec::Example::ExampleGroup)
Remarkable.add_locale(File.dirname(__FILE__) + '/en.yml')