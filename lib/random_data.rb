module RandomData


  def self.random_name
    first_name = random_word.capitalize
    last_name = random_word.capitalize
    "#{first_name} #{last_name}"
  end

  def self.random_email
    "#{random_word}@#{random_word}.#{random_word}"
  end

  def self.random_paragraph
    sentences = []
    rand(4..8).times do
      sentences << random_sentence
    end

    sentences.join(" ")
  end

  def self.random_sentence
    strings = []
    rand(3..5).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

  def self.random_word
    letters = ["a", "a", "a", "a", "a", "a", "a", "b", "b", "c", "c", "c", "d", "d", "d", "d", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "f", "f", "f", "g", "g", "h", "h", "h", "h", "h", "h", "i", "i", "i", "i", "i", "i", "i", "i", "j", "j", "k", "l", "l", "l", "l", "m", "m", "m", "n", "n", "n", "n", "n", "n", "n", "n", "o", "o", "o", "o", "o", "o", "o", "o", "p", "p", "q", "r", "r", "r", "r", "r", "r", "s", "s", "s", "s", "s", "s", "s", "s", "t", "t", "t", "t", "t", "t", "t", "t", "t", "u", "u", "u", "v", "w", "w", "x", "y", "y", "z"]
    letters.sample(rand(3..8)).join
  end

end
