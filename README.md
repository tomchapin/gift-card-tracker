Gift Card Tracker
=================

Project Objective:
----------

Create a rails app that allows you to add gift cards and track their balance. 
 
1. Add/remove a gift card 
  - Fields to store: issuing company(Home Depot, BestBuy), card_number, balance  
  - Use credit card numbers as the card numbers 
  - Validate card numbers are valid credit card numbers

2. Show info for each card 

3. Credit/Debit from each gift card balance 
  - Allow to add and remove from balance of each card
  - Do not allow a debit for an amount that would puts the balance negative


Requirements
-------------

This application requires:

- Ruby 2.2.3
- Rails 4.2.5
- PostgreSQL


Getting Started
---------------

1. Create a local PostgreSQL user: "```createuser gift-card-tracker --superuser```"

2. Run "```bundle install```"

3. Run "```rake db:create db:migrate db:seed```" to set up the database.

   **IMPORTANT: Don't forget to seed the database so you have all of the gift card issuers in the database!**

4. Run "```rails s```" to start the rails server

5. Browse to "http://localhost:3000" in your web browser


Running Tests
-------------

1. Prepare the test database: "```rake db:test:prepare```"

2. Run either "```guard```" for continuous testing, or "```rspec```" for one-off testing


Viewing Test Coverage
---------------------

After you have executed the test suite at least once, simply run "```open coverage/index.html```"
from the project root to open the SimpleCov coverage statistics in your default web browser.