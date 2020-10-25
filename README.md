# MemberPointTracker
A rails webapp that is used by tamu organizations to take and track member attendance.

Steps to setup Rspec and Capybara
1. In gem filed under group ':development, :test do' include these 4 gems
   
    a. gem 'rspec-rails'

    b. gem 'capybara', '>= 2.15'
    
    c. gem 'selenium-webdriver'
    
    d. gem 'webdrivers'
    
2.  run bundle install 
3.  You should have spec directory
4.  In that directory you can add tests. Look at spec/views/login_pace_spec.rb for reference
5. to run do 'bundle exec rspec .\spec\directoryName\rspecFileName.rb'
    '#' example: bundle exec rspec .\spec\views\login_page_spec.rb
    '#' not sure why we need 'bundle exec' might have to fix this later
    
reference this page for more info: https://www.codewithjason.com/rails-testing-hello-world-using-rspec-capybara/
