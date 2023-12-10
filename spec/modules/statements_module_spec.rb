require 'rails_helper'

RSpec.describe StatementsModule do
  describe "class methods" do
    describe "#random_zen_statement" do
      it "samples a random zen statement from the ZEN_STATEMENTS array" do
        expect(StatementsModule::ZEN_STATEMENTS).to include(StatementsModule.random_zen_statement)
      end
    end

    describe "#random_motivational_statement" do
      it "samples a random motivational statement from the MOTIVATIONAL_STATEMENTS array" do
        expect(StatementsModule::MOTIVATIONAL_STATEMENTS).to include(StatementsModule.random_motivational_statement)
      end
    end
  end
end