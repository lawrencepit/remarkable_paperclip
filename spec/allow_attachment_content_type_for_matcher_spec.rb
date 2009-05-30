require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe "allow_attachment_content_type_for" do
  before :all do
    Person.validates_attachment_content_type :avatar, :content_type => %r{^image/}
    @subject = Person.new
  end

  describe "messages" do
    before(:each) do
      @matcher = allow_attachment_content_type_for(:avatar, "image/png", "image/gif", "image/jpg")
    end

    it "should contain a description" do
      @matcher.description.should == 'allow "image/png", "image/gif", and "image/jpg" as content type for attachment :avatar'
    end

    it 'should set is_valid? message' do
      @matcher.in("A").matches?(@subject)
      @matcher.failure_message.should == 'Expected Person to be valid when content type for attachment :avatar is set to "A"'
    end
  end

  describe 'matchers' do
    it { should allow_attachment_content_type_for(:avatar, "image/png", "image/gif") }
    it { should allow_attachment_content_type_for(:avatar, ["image/png", "image/gif"]) }
    it { should_not allow_attachment_content_type_for(:avatar, "video/mpeg") }
    it { should_not allow_attachment_content_type_for(:avatar, ["video/mpeg"]) }
  end

  describe 'aliases' do
    it { should validate_attachment_content_type(:avatar, "image/png", "image/gif") }
  end

end