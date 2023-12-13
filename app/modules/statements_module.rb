module StatementsModule
  ZEN_STATEMENTS = [
    "In the silence of serenity, find your peace",
    "When the river of tranquility flows, be its gentle stream",
    "Breathe in the calm, exhale the chaos",
    "May your serenity be as vast as the starlit sky",
    "In the garden of inner peace, cultivate your serenity",
    "Like a mindful master, dance through the moments with grace",
    "As the symphony of life plays, find your harmonious melody",
    "May your thoughts be as tranquil as a quiet lake",
    "In the art of mindful living, be the serene artist",
    "When the winds of change blow, let them carry your worries away",
    "Like a poetic philosopher, write verses of tranquility in your heart",
    "As the lotus blooms in muddy waters, find your purity",
    "May your inner garden be a haven of peaceful blossoms",
    "In the dance of yin and yang, find balance",
    "Like a philosophical seeker, seek wisdom in the simplicity of now",
    "When the candle of peace flickers, be its steady flame",
    "May your journey be a mindful walk on the path of tranquility",
    "In the tapestry of existence, weave threads of tranquility",
    "Like a mindful sculptor, shape your moments with mindfulness",
    "As the morning dew settles, let calm settle within",
  ]

  MOTIVATIONAL_STATEMENTS = [
    "Believe in your abilities and embrace the challenge.",
    "You are stronger and more capable than you think.",
    "Face each task with confidence and determination.",
    "No obstacle is too big for you to overcome.",
    "Visualize your success and work towards it.",
    "Your strength lies in your resilience and perseverance.",
    "Take one step at a time towards your goals.",
    "Trust in your skills and keep pushing forward.",
    "Doubt your doubts and stay positive.",
    "Embrace the journey, success is a step away.",
    "You have the power to overcome any challenge.",
    "Stay focused, success is the result of your effort.",
    "Conquer your fears and step into your greatness.",
    "Your effort today paves the way for success tomorrow.",
    "Rise above the challenges with determination.",
    "You are unstoppable when you set your mind to it.",
    "Success is within your reach, keep reaching.",
    "Persevere and keep moving towards your dreams.",
    "Believe in the beauty of your dreams.",
    "You are capable of achieving greatness.",
  ]


  def self.random_zen_statement
    ZEN_STATEMENTS.sample
  end

  def self.random_motivational_statement
    MOTIVATIONAL_STATEMENTS.sample
  end
end
