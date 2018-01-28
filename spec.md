# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
--Created 4 migrations for tables and modified with ActiveRecord models
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
--Includes User, Item, Grocery List, Grocery List Item
- [s] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
--User has many grocery Lists
--User has many items
--Grocery List has many items, etc
- [x] Include user accounts
--Can signup and login with user
- [x] Ensure that users can't modify content created by other users
--Checks if a user is signed in with sessions
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
Both Items and Grocery Lists can be CRUD
- [x] Include user input validations
--If certain forms are empty, raises an error
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
--rack-flash gem used to indicated validations
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
--README included in project
Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
