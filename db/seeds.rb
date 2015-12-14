# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Load all of the card issuers into the database
card_issuer_names = YAML::load_file Rails.root.join('db', 'seeds', 'card_issuers.yml')
card_issuer_names.each do |card_issuer_name|
  CardIssuer.find_or_create_by(name: card_issuer_name) do |card_issuer|
    puts "Created Card Issuer: #{card_issuer.name}"
  end
end
