if RAILS_ENV == 'test'
  require 'spec'
  require 'spec/rails'
  require 'remarkable_rails'
  require File.dirname(__FILE__) + "/lib/remarkable_paperclip"
end