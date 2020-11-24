# MemberPointTracker
A rails webapp that is used by tamu organizations to take and track member attendance.

## Prerequisites

1. Have Ruby on Rails Installed
    * https://www.tutorialspoint.com/ruby-on-rails/rails-installation.htm
    
2. Have PostgreSQL Intalled
    * https://www.postgresql.org/download/
    
3. Have Yarn installed (for Bootstrap)
    * https://classic.yarnpkg.com/en/docs/install/#windows-stable
4. We used this guide for setting up bootstrap so if you have any issues refer to this
    * https://www.youtube.com/watch?v=BIxd501hP-g
    
## How to Execute Code

1. Clone Github repo: https://github.com/FA20-CSCE431/group-project-asabe-member-point-tracker
2. Update ruby version in Gemfile to your working version
    * run 'ruby -v' to check your working version
3. Create your databse.yml file in 'config/database.yml'. See below for template.

    > default: &default  
    > adapter: postgresql  
    > encoding: unicode
    >   pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    
    > development:  
    > <<: *default    
    > database: your_db_dev  
    > username: your_username    
    > password: your_password
    
    > test:  
    > <<: *default    
    > database: your_db_test  
    > username: your_username    
    > password: your_password
    
    > production:  
    > <<: *default    
    > database: your_db_production  
    > username: your_username    
    > password: your_password
    
4. Run 'bundle install' to install all gems

5. Run 'rails db:migrate' to run database migrations
6. Run 'rails server' to launch app locally
7. Go to 'http://localhost:3000/'
    * or any other port you specified

## How to Deply code in Heroku
The easiest way to deploy code in Heroku is to setup CD with Heroku. Start by going to your project in Heroku as all of these steps can be done there.Note that CD can also be setup through a pipeline along with CI as described in one of the TA's videos.
1. Connect the github repository to the Heroku app.
2. Enable automatic deployment and select master as the branch to use.
3. Add a procfile to your project with any commands you need to run on every build. Most likely you will just need the command we used which starts the database so consider copying our procfile.
4. Refer to Heroku documentation for other commands you need.

## How to perform CI
The easiest way to figure this out is to refer to the video left by the TA. For our class it was in the labs section on eCampus. If it's not there consider asking Professor Wade or the TA.
## How to Perform Security Tests

For security tests in our application we use the Brakeman gem to detect potential SQL injections.
1. Verify brakeman is installed by running 'gem list' and checking if brakeman is in the list
    * if not, refer to this documentation to install brakeman: https://brakemanscanner.org/docs/install/
    
2. run 'brakeman' to execute the gem

### References
    
* Rspec and capybara: https://www.codewithjason.com/rails-testing-hello-world-using-rspec-capybara/
* Ruby on Rails 5 guide: https://www.linkedin.com/learning/ruby-on-rails-5-essential-training/welcome?u=74650722
* Ruby on Rails with Postgres: https://www.digitalocean.com/community/tutorials/how-to-set-up-ruby-on-rails-with-postgres
* Bootstrap: https://getbootstrap.com/docs/4.0/layout/overview/
* Rubocop: https://docs.rubocop.org/rubocop/1.2/usage/basic_usage.html


