require 'spec_helper'

describe Style do
  describe "style is created" do
    it "with correct parameters" do
      style = FactoryGirl.create(:style)
      expect(style).to be_valid
      expect(Style.count).to eq(1)
    end
  end
end
