require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe "validate_attachment_content_type" do
  before :all do
    Person.validates_attachment_content_type :avatar, :content_type => %r{^image/}
    @subject = Person.new
  end

  describe "messages" do
    it "should contain a description" do
      @matcher = validate_attachment_content_type(:avatar)
      @matcher.matches?(@subject)
      @matcher.description.should == 'validate attachment content type of attached file :avatar'
    end

    it "should set allows_match? message" do
      @matcher = validate_attachment_content_type(:avatar).allows(["video/mpeg"])
      @matcher.matches?(@subject)
      @matcher.failure_message.should == 'Expected Person to accept content types ["video/mpeg"] for attached file :avatar'
    end

    it "should set rejects_match? message" do
      @matcher = validate_attachment_content_type(:avatar).rejects(["image/png"])
      @matcher.matches?(@subject)
      @matcher.failure_message.should == 'Expected Person to reject content types ["image/png"] for attached file :avatar'
    end
  end

  describe 'matchers' do
    it { should validate_attachment_content_type(:avatar, :allows => ["image/png", "image/gif"], :rejects => ["video/mpeg"]) }

    it { should_not validate_attachment_content_type(:avatar, :allows => ["video/mpeg"]) }
    it { should_not validate_attachment_content_type(:avatar, :allows => ["image/png", "image/gif", "video/mpeg"]) }
  end

end