# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'
require 'faker'
  # Create Users
  12.times do
    begin
      name = Faker::Hobbit.character
      User.create!(
      name:     name,
      email:    Faker::Internet.unique.free_email(name.split(' ').join('-')),
      password: Faker::Internet.password
      )
    rescue Faker::UniqueGenerator::RetryLimitExceeded
      Faker::UniqueGenerator.clear
    end
  end

  User.create!(
    name: "Nelson",
    email: "nelson@blocipedia.com",
    password: "password",
    role: "premium"
  )
  users = User.all

  #create Wikis
  25.times do
    begin
      title = [Faker::Hacker.ingverb.capitalize, Faker::Hacker.unique.adjective.capitalize, Faker::Food.dish].join(' ')
      wiki = Wiki.create!(
        user:   users.sample,
        title:  title,
        body:   [Faker::SiliconValley.quote, Faker::Hobbit.quote].sample(2).join(' '),
        private: Faker::Boolean.boolean(0.2)
      )
      wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
    rescue Faker::UniqueGenerator::RetryLimitExceeded
      Faker::UniqueGenerator.clear
    end
  end
  wikis = Wiki.all

  #create Collaborators
  40.times do
    swiki = wikis.sample
    colaborator = Collaborator.create!(
      wiki: swiki,
      user: (users - [swiki.user]).sample
    )

  end

  #create Admin User
  User.create!(
    name: "Admin",
    email: "admin@blocipedia.com",
    password: "password",
    role: "admin"
  )

  puts "#{User.count} users created"
  puts "#{Wiki.count} wikis created"
  puts "#{Collaborator.count} collaborators created"
