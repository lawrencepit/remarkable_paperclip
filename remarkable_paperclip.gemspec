Gem::Specification.new do |s|
  s.name         = "remarkable_paperclip"
  s.version      = "0.6.3"
  s.author       = "Lawrence Pit"
  s.email        = "lawrence.pit@gmail.com"
  s.homepage     = "http://github.com/lawrencepit/remarkable_paperclip"
  s.summary      = "Remarkable matchers for Paperclip."
  s.files        = ["README.markdown", "MIT-LICENSE", "locale/en.yml", "lib/paperclip/extension.rb", "lib/remarkable_paperclip.rb", "lib/matchers/have_attached_file_matcher.rb", "lib/matchers/validate_attachment_presence_matcher.rb", "lib/matchers/validate_attachment_size_matcher.rb", "lib/matchers/allow_attachment_content_type_for_matcher.rb"]
  s.require_path = "lib"
  s.has_rdoc     = false
end
