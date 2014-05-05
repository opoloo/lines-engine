require "spec_helper"

module Lines

  describe Article do
    it "has a valid factory" do
      FactoryGirl.create(:article).should be_valid
    end

    it "is invalid without a title" do
      FactoryGirl.build(:article, title: nil).should_not be_valid
    end

    it "is invalid without content" do
      FactoryGirl.build(:article, content: nil).should_not be_valid
    end

    it "is invalid with neither hero_image nor short_hero_image " do
      FactoryGirl.build(:article, hero_image: nil, short_hero_image: nil).should_not be_valid
    end

    it "is invalid with both a hero_image and a short_hero_image" do
      FactoryGirl.build(:article, short_hero_image: 1 ).should_not be_valid
    end

    it "is invalid without one or more authors" do
      FactoryGirl.build(:article, author_ids: nil).should_not be_valid
    end

  end

end