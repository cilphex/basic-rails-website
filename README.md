# Basic Rails Website

Just something for myself to clone when I start a new app.

Replace these instances of "basic website" (or similar) with your project name:

./app/views/layouts/application.html.erb:4: <title>Basic Website</title>
./app/views/layouts/application.html.erb:6: <meta name="description" content="A basic website">
./app/views/layouts/application.html.erb:7: <meta name="keywords" content="basic, website">
./config/application.rb:19: module BasicWebsite
./config/initializers/session_store.rb:3: Rails.application.config.session_store :cookie_store, key: '_basic_website_session'

Most of the work is in hooking up the services on heroku that this relies on. Those include:

- Mongo DB (Mongolab)
- Keen (stats)
- Mandrill (for email)
- Redis (open redis)
- Rollbar (bug tracking)