Remarkable Paperclip
====================

Test matchers to test Paperclip with Remarkable.

Usage
-----

    it { should have_attached_file :avatar, :styles => { :ico => "16x16", :normal => "48x48" } }
    it { should validate_attachment_presence :avatar }
    it { should validate_attachment_size :avatar, :less_than => 1.megabyte }
    it { should validate_attachment_content_type :avatar, :allows => ["image/png", "image/jpg"], :rejects => ["video/mpeg"] }


Installation
------------

### As a Gem

Use this if you prefer to use versioned releases of remarkable_paperclip.
Specify the gem dependency in your config/environments/test.rb file:

    Rails::Initializer.run do |config|
      config.gem "remarkable_paperclip", :lib => false, :source => "http://gemcutter.org"
    end

Then:

    $ rake gems:install
    $ rake gems:unpack

Then require remarkable_paperclip from your spec/spec_helper.rb file, before Spec::Runner is configured:

    # requires for RSpec
    require 'remarkable_paperclip'
    Spec::Runner.configure do |config|
    # ...


### As a Plugin

Use this if you prefer to use the edge version of remarkable_paperclip:

    $ script/plugin install git://github.com/lawrencepit/remarkable_paperclip.git


Credits
-------

Written by [Lawrence Pit](http://lawrencepit.com).

Thanks to
[Remarkable](http://github.com/carlosbrando/remarkable) and
[Paperclip](http://github.com/thoughtbot/paperclip).



----
Copyright (c) 2009 Lawrence Pit, released under the MIT license
