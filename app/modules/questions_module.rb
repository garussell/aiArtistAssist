module QuestionsModule
  STYLE_QUESTIONS = [
    "Capture your essence in a phrase.",
    "Summarize your vision briefly.",
    "Define your aesthetic succinctly.",
    "Express your style concisely.",
    "Condense your creativity into a few words.",
    "Describe your design philosophy briefly.",
    "Sum up your artistic approach.",
    "Characterize your visual identity in a phrase.",
    "Capture your vibe in three words.",
    "Define your aesthetic in a nutshell.",
    "Express your design ethos briefly.",
    "In a few words, convey your artistic signature.",
    "Summarize your creative essence.",
    "Define your style in three words or less.",
    "Express your design philosophy succinctly.",
    "Capture your visual language briefly.",
    "Condense your creative spirit into a phrase.",
    "Define your artistic identity succinctly.",
    "Summarize your design approach briefly.",
    "Express your aesthetic in three words.",
  ]
  

  GOALS_QUESTIONS = [
    "Share the details of your current endeavor.",
    "Tell me about the project you're working on.",
    "Describe your ongoing creative pursuit.",
    "What's the focus of your current venture?",
    "Discuss the goals of your latest initiative.",
    "Elaborate on the project you're currently immersed in.",
    "What's the scoop on your ongoing endeavor?",
    "Share insights into your latest project.",
    "Detail the objectives of your current undertaking.",
    "Provide an overview of your present project.",
    "What's the story behind your current project?",
    "Describe the essence of your ongoing venture.",
    "Give me a snapshot of your current creative project.",
    "Discuss the goals and aspirations of your latest project.",
    "What's the status of your current creative pursuit?",
    "Share the journey of your ongoing project.",
    "Describe the motivations behind your current initiative.",
    "Discuss the key aspects of your present project.",
    "Tell me about the progress of your latest venture.",
    "What's the purpose behind your current creative endeavor?",
  ]
  


  def self.random_style_question
    STYLE_QUESTIONS.sample
  end

  def self.random_goal_question
    GOALS_QUESTIONS.sample
  end
end