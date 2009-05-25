require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe "have_attached_file" do
  before :each do
    @subject = Person.new
  end

  describe "messages" do
    it "should contain a description" do
      @matcher = have_attached_file(:avatar)
      @matcher.matches?(@subject)
      @matcher.description.should == 'have attached file :avatar'
    end

    it "should set defined? message" do
      @matcher = have_attached_file(:not_exists)
      @matcher.matches?(@subject)
      @matcher.failure_message.should == 'Expected Person has :not_exists as an attached file'
    end

    it "should set has_column? message" do
      @matcher = have_attached_file(:cv)
      @matcher.matches?(@subject)
      @matcher.failure_message.should == 'Expected table people to have column cv_file_name, but it does not'
    end

    it "should set styles_match? message" do
      @matcher = have_attached_file(:avatar, :styles => { :ico => "16x16" })
      @matcher.matches?(@subject)
      @matcher.failure_message.should == 'Expected Person to have attached file :avatar with styles {:ico=>"16x16"}, got {:ico=>"16x16", :normal=>"48x48"}'
    end
  end

  describe 'matchers' do
    it { should have_attached_file(:avatar) }
    it { should have_attached_file(:avatar, :styles => { :ico => "16x16", :normal => "48x48" }) }
    it { should have_attached_file(:photo, :styles => { :ico => ["16x16#", :png], :normal => { :geometry => "48x48#", :format => :png } }) }
    it { should have_attached_file(:photo, :styles => { :ico => "16x16#", :normal => "48x48#" }) }

    it { should_not have_attached_file(:not_exists) }
    it { should_not have_attached_file(:avatar, :styles => { :ico => "16x16" }) }
    it { should_not have_attached_file(:avatar, :styles => { :ico => "16x16", :normal => "48x48", :large => "128x128" }) }
  end

end
