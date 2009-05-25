require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe "validate_attachment_presence" do
  before :all do
    Person.validates_attachment_presence :avatar
    @subject = Person.new
  end

  describe "messages" do
    it "should contain a description" do
      @matcher = validate_attachment_presence(:avatar)
      @matcher.matches?(@subject)
      @matcher.description.should == 'validate attachment presence of attached file :avatar'
    end

    it "should set invalid_when_not_present? message" do
      @matcher = validate_attachment_presence(:photo)
      @matcher.matches?(@subject)
      @matcher.failure_message.should == 'Expected Person to be invalid when attached file :photo is not present'
    end
  end

  describe 'matchers' do
    it { should validate_attachment_presence(:avatar) }
    it { should_not validate_attachment_presence(:photo) }
  end

end