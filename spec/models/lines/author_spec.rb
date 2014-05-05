require "spec_helper"

module Lines

  describe Author do
    it "has a valid factory" do
      FactoryGirl.create(:author).should be_valid
    end

    it "is invalid without a name" do
      FactoryGirl.build(:author, name: nil).should_not be_valid
    end

    it "is invalid without an email" do
      FactoryGirl.build(:author, email: nil).should_not be_valid
    end

    it "is invalid without a description" do
      FactoryGirl.build(:author, description: nil).should_not be_valid
    end

    it "can not be deleted if belonging to one or more articles" do
      author = FactoryGirl.create(:author)
      author.articles << FactoryGirl.create(:article)
      author.destroy.should be_false
    end
  end

end