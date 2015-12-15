Gift Card Tracker
=================

[![Build Status](https://travis-ci.org/tomchapin/gift-card-tracker.svg?branch=master)](https://travis-ci.org/tomchapin/gift-card-tracker)
[![Coverage Status](https://coveralls.io/repos/tomchapin/gift-card-tracker/badge.svg?branch=master&service=github)](https://coveralls.io/github/tomchapin/gift-card-tracker?branch=master)

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

1. Copy the "config/database.example.yml" file to "config/database.yml"

2. Create a local PostgreSQL user: "```createuser gift-card-tracker --superuser```"

3. Run "```bundle install```"

4. Run "```rake db:create db:migrate db:seed```" to set up the database.

   **IMPORTANT: Don't forget to seed the database so you have all of the gift card issuers in the database!**

5. Run "```rails s```" to start the rails server

6. Browse to "http://localhost:3000" in your web browser


Running Tests
-------------

1. Prepare the test database: "```rake db:test:prepare```"

2. Run either "```guard```" for continuous testing, or "```rspec```" for one-off testing


Viewing Test Coverage
---------------------

After you have executed the test suite at least once, simply run "```open coverage/index.html```"
from the project root to open the SimpleCov coverage statistics in your default web browser.