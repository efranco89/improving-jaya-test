# README

This application was created as a testing to listen Github Events via webhooks
The stored events will be eventually consume via API.

This is an only API application

Things you may want to cover:

* Ruby version

  Ruby 2.7.1
  Rails 6.0.4.4
  sqlite3

* System dependencies

  The creation of the events depends of the repository documentation

  if you are not familiar with webhooks please take a look of the following docs:

    - Webhooks Overview: https://developer.github.com/webhooks/
    - Creating Webhooks : https://developer.github.com/webhooks/creating/

* Configuration

  1. Run the command to create and migrate de Data Base, rails db:create && rails db:migrate.

  2. Run rails s -p 4000 or the port you desire.

  3. For being able to expose your localhost to the web you should install ngrok
  ubuntu user can type in the terminal snap install ngrok other OS please check
  https://ngrok.com/download.

  4. Start the ngrok service by typing in you terminal ngrok http rails_local_port.

    e.g. ngrok http 4000

  5. Set up the repository you want to create the webhook.

    5.1.  Go to the desire repository.
    5.2.  Go to Settings and select Webhooks.
    5.3.  Click on Add webhook.
    5.4.  Payload URL must be the forwarding URL generated by ngrok plus /events
          e.g. http://c908-186-86-34-17.ngrok.io/events.
    5.5.  Content type please select application/json otherwise you wont be able
          to receive data.
    5.6.  Secret set a token to Github be able to access the API. ATENTION this
          token must be set as a enviroment variable.
    5.7.  Create The enviroment variable with the token the identifier must be
          GITHUB_TOKEN.

          e.g. Linux User export GITHUB_TOKEN=XXXXXXXXXXXXX or modify you bash at /home/user/.bashrc at the end of the file add export GITHUB_TOKEN="your_github_secret"

* Database creation

The database use is sqlite3 not user necessary

* How to run the test suite

  1. For running the test you should go to the root of the project and run rspec spec

  2. The testing scenarios are ready with the enviroment variables you wont need to set any of those.

* Services (job queues, cache servers, search engines, etc.)
