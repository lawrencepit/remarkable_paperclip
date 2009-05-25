if RAILS_ENV == 'test'
  require 'spec/rails'
  require 'remarkable'
  require File.dirname(__FILE__) + "/lib/remarkable_paperclip"
end