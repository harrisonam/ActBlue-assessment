# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


def seed_users
    40.times do
        User.find_or_create_by(name: Faker::Name.name, email: Faker::Internet.email)
    end
    puts "Created 40 users"
end

def seed_polls
    1.times do
        Poll.find_or_create_by(name: "#{Faker::Job.title} of the Year Award")
    end
    puts "Created 1 poll with id #{Poll.last.id}"
end

def seed_candidates
    5.times do
        Candidate.find_or_create_by(name: Faker::Name.name, poll: Poll.last)
    end
    puts "Created 5 candidates for Poll with id #{Poll.last.id}"
end

def seed_votes
    User.all.each do |user|
        Vote.find_or_create_by(candidate: Candidate.all[rand(1..6)], user: user)
    end
    puts "Created votes for Poll with id #{Poll.last.id}"
end

seed_users
seed_polls
seed_candidates
seed_votes
