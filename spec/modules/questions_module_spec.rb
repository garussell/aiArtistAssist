require 'rails_helper'

RSpec.describe QuestionsModule do
  describe "class methods" do
    describe "#random_style_question" do
      it "samples a random style question from the STYLE_QUESTIONS array" do
        expect(QuestionsModule::STYLE_QUESTIONS).to include(QuestionsModule.random_style_question)
      end
    end

    describe "#random_goal_question" do
      it "samples a random goal question from the GOALS_QUESTIONS array" do
        expect(QuestionsModule::GOALS_QUESTIONS).to include(QuestionsModule.random_goal_question)
      end
    end
  end
end