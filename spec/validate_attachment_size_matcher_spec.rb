require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe "validate_attachment_size" do
  describe "messages" do
    before :all do
      Person.validates_attachment_size :avatar, :in => 100..110
      @subject = Person.new
    end

    it "should contain a description when :in is used" do
      @matcher = validate_attachment_size(:avatar, :in => 100..110)
      @matcher.matches?(@subject)
      @matcher.description.should == 'validate size for attached file :avatar to be in 100..110'
    end

    it "should contain a description when :less_than is used" do
      @matcher = validate_attachment_size(:avatar, :less_than => 110)
      @matcher.matches?(@subject)
      @matcher.description.should == 'validate size for attached file :avatar to be less than 110'
    end

    it "should contain a description when :greater_than is used" do
      @matcher = validate_attachment_size(:avatar, :greater_than => 110)
      @matcher.matches?(@subject)
      @matcher.description.should == 'validate size for attached file :avatar to be greater than 110'
    end

    it "should set is_minimum? message" do
      @matcher = validate_attachment_size(:avatar, :in => 99..110)
      @matcher.matches?(@subject)
      @matcher.failure_message.should == 'Expected Person to be valid when size of attached file :avatar is 99'
    end

    it "should set less_than_minimum? message" do
      @matcher = validate_attachment_size(:avatar, :in => 101..110)
      @matcher.matches?(@subject)
      @matcher.failure_message.should == 'Expected Person to be invalid when size of attached file :avatar is less than 101'
    end

    it "should set is_maximum? message" do
      @matcher = validate_attachment_size(:avatar, :in => 100..111)
      @matcher.matches?(@subject)
      @matcher.failure_message.should == 'Expected Person to be valid when size of attached file :avatar is 111'
    end

    it "should set more_than_maximum? message" do
      @matcher = validate_attachment_size(:avatar, :in => 100..109)
      @matcher.matches?(@subject)
      @matcher.failure_message.should == 'Expected Person to be invalid when size of attached file :avatar is more than 109'
    end

  end

  describe 'matchers with :in' do
    before :all do
      Person.validates_attachment_size :avatar, :in => 100..110
      @subject = Person.new
    end

    it { should validate_attachment_size(:avatar, :in => 100..110) }

    it { should_not validate_attachment_size(:avatar, :in => 100..111) }
    it { should_not validate_attachment_size(:avatar, :in => 99..110) }
    it { should_not validate_attachment_size(:avatar, :in => 101..110) }
    it { should_not validate_attachment_size(:avatar, :in => 100..109) }
    it { should_not validate_attachment_size(:avatar, :less_than => 110) }
    it { should_not validate_attachment_size(:avatar, :greater_than => 100) }
  end

  describe 'matchers with :less_than' do
    before :all do
      Person.validates_attachment_size :avatar, :less_than => 110
      @subject = Person.new
    end

    it { should validate_attachment_size(:avatar, :less_than => 110) }
    it { should validate_attachment_size(:avatar, :in => 0..110) }

    it { should_not validate_attachment_size(:avatar, :less_than => 109) }
    it { should_not validate_attachment_size(:avatar, :less_than => 111) }
    it { should_not validate_attachment_size(:avatar, :greater_than => 0) }
    it { should_not validate_attachment_size(:avatar, :greater_than => 110) }
    it { should_not validate_attachment_size(:avatar, :in => 0..109) }
    it { should_not validate_attachment_size(:avatar, :in => 0..111) }
  end

  describe 'matchers with :greater_than' do
    before :all do
      Person.validates_attachment_size :avatar, :greater_than => 110
      @subject = Person.new
    end
  
    it { should validate_attachment_size(:avatar, :greater_than => 110) }
    it { should validate_attachment_size(:avatar, :in => 110..(1.0/0)) }
  
    it { should_not validate_attachment_size(:avatar, :greater_than => 109) }
    it { should_not validate_attachment_size(:avatar, :greater_than => 111) }
    it { should_not validate_attachment_size(:avatar, :less_than => 200) }
    it { should_not validate_attachment_size(:avatar, :less_than => 110) }
    it { should_not validate_attachment_size(:avatar, :in => 109..(1.0/0)) }
    it { should_not validate_attachment_size(:avatar, :in => 111..(1.0/0)) }
  end

end
