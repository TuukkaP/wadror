require 'spec_helper'

describe Beer do
  describe "is created" do
    it "with correct parameters" do
      beer = FactoryGirl.create(:beer)
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "with 3 identical beers" do
      beer1 = FactoryGirl.create(:beer)
      beer2 = FactoryGirl.create(:beer)
      beer3 = FactoryGirl.create(:beer)
      expect(Beer.count).to eq(3)
    end
  end
  describe "is not created" do
    it "if name is missing" do
      style = FactoryGirl.create(:style)
      beer = Beer.create style:style, brewery_id:1
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
    it "if style is missing" do
      beer = Beer.create name:"olut", brewery_id:1
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
