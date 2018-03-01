FactoryBot.define do
  factory :wiki do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    private false
    user User.all.sample
  end
end
