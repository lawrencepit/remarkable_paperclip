dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir + '/../lib'
require 'rubygems'
require 'activerecord'
require 'spec'
require 'remarkable_activerecord'
require 'remarkable_paperclip'

ActiveRecord::Base.configurations = YAML::load(IO.read(dir + '/db/database.yml'))
ActiveRecord::Base.logger = Logger.new(dir + '/db/debug.log')
ActiveRecord::Base.establish_connection('sqlite3')
load(dir + '/db/schema.rb')

require 'paperclip'
class Person < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :ico => "16x16", :normal => "48x48" }
  has_attached_file :photo,
                    :styles => { :ico => ["16x16#", :png], :normal => { :geometry => "48x48#", :format => :png } },
                    :default_style => :normal,
                    :storage => :s3
  has_attached_file :cv
end

RAILS_ROOT = nil

