# MemberPointTracker
A rails webapp that is used by tamu organizations to take and track member attendance.

Steps to setup Rspec and Capybara
1. In gem filed under group ':development, :test do' include:
    #rspec testing framework
    gem 'rspec-rails'

    # Adds support for Capybara system testing and selenium driver
    gem 'capybara', '>= 2.15'
    gem 'selenium-webdriver'
    # Easy installation and use of web drivers to run system tests with browsers
    gem 'webdrivers'
2.  run bundle install
3.  You should have spec directory
4.  In that directory you can add tests. Look at spec/views/login_pace_spec.rb for reference
5. to run do 'bundle exec rspec .\spec\directoryName\rspecFileName.rb'
    # example: bundle exec rspec .\spec\views\login_page_spec.rb
    # not sure why we need 'bundle exec' might have to fix this later
6. Before compiling the spec files, making use you have:
       1) Create a new officer account with email => "admin@email.com" and password => "password".
       2) An empty Members table in your local database.
       3) Then create a new user with name => "John Doe" and uin => "123456" (Put whatever you want for email and leave points as 0 by default)
