Take a Hike!
====

Take a Hike! is a location-based gamified app for tourists.

Through a web-based content management system (a website) and mobile app in two different versions ([iOS](https://github.com/codeforeurope/gohike-ios), [Android](https://github.com/codeforeurope/gohike-android)), Take a Hike! offers a location-based gamified experience for tourists, based on a "scavenger hunt" concept. 

Curators can create multiple routes based on locations/attractions in different cities.

Visitors can play the routes on their mobile devices, discovering new places and earning rewards to share with friends on social networks.

Take a Hike! was developed during [Code for Europe 2013](http://www.codeforeurope.net) in Amsterdam and is published in the [Civic Exchange app catalog](http://www.civicexchange.eu/app/take-hike).

What does the app do?
---

Take a Hike CCS (content curation system) allows content creators to define "routes" (collections of points of interest) that can be viewed through the associated mobile apps (for [iOS](https://github.com/codeforeurope/gohike-ios) and  [Android](https://github.com/codeforeurope/gohike-android)). 
Everything in Take a Hike can be customized: from the list of cities where the app is deployed to the categories ("Profiles") of the routes to the single point of interests (called "Locations"). 
Routes have "Rewards" associated to them: this means that when a mobile user discovers all the locations contained in that route, she or he can publish the reward (a digital "badge") to a social network (Facebook is already implemented out-of-the-box, although it requires the developer to create a new Facebook App).
Once a route is defined, the content managers can "Publish" it and make it available to the mobile apps through a high-performance database (offered by Redis Cloud in the current setup). 


Deploy Take a Hike API
===

Required cloud services accounts
---
* A free [Heroku](http://www.heroku.com)  account
* An [Amazon AWS](http://aws.amazon.com/) account in order to use Amazon S3 storage service. The app will upload all the media (pictures) to the S3 bucket. 
* A Facebook account in order to [create a new Facebook App](https://developers.facebook.com/). This is not strictly required to run the application, however the mobile apps will require Facebook Login in order to post the "rewards" on the social network, and the web app will use the Facebook App credentials to enable the "Facebook login" functionality. 
* (Optional) a [Google Analytics](google.com/analytics/) account

Setup Steps
---

* Create a S3 bucket on Amazon AWS console and set a proper policy for the app to upload content to it. 
* Login to Heroku from command line using the `heroku login` command
* Create a Heroku app with the `heroku create` command
* Add the following Add-Ons
	* Postgres (should be enabled by default)
	* [Redis Cloud Starter](https://addons.heroku.com/rediscloud) in order to store the published "zip" file containing the routes to be downloaded by the mobile users
     `heroku addons:add rediscloud`
	* [Sendgrid](https://addons.heroku.com/sendgrid) 
	`heroku addons:add sendgrid`
* Add a environment variable called `APP_SECRET` through the Heroku Console, containing a sufficiently long string. This will be the API Key for the application. 
`heroku config:set APP_SECRET=your_string_here`
* Add `S3_ACCESS` and `S3_SECRET` environment variables, using your Amazon S3 access Key and Secret. 
* Add `FACEBOOK_APP_ID` and `FACEBOOK_APP_SECRET` environment variables, using the ones defined in the Facebook app
* (Optional) Add a 
* Push the app to Heroku: `git push heroku master`
* Migrate the database `heroku run rake db:migrate` 


Configuration Variables
---

Most of the configuration is stored in the environment variables, however some variables defined in the application files should be changed for your setup.

File `production.rb` in `config/environments`:

      config.action_mailer.default_url_options = { :host => 'www.yourdomainname.com' }

File `carrierwave.rb` in `config/initializers`:

      config.fog_directory  = 'your_bucket_name_on_s3' # required

File `devise.rb` in `config/initializers`:

      config.mailer_sender = "info@yourdomainname.com"

Modify the Google Analytics domain where required, in `reward.html.erb` and `start.html.rb`. 

Env file and config variables
---

To double check that your configuration matches the one of the tested instance, running `heroku config` on the command line should return something like this:


    APP_SECRET:                 xXxXxXxXxXx
    DATABASE_URL:               postgres://xXxXxXxXxXx
    FACEBOOK_APP_ID:            1234567890123
    FACEBOOK_APP_SECRET:        xXxXxXxXxXx
    HEROKU_POSTGRESQL_AQUA_URL: postgres://xXxXxXxXxXx
    PGBACKUPS_URL:              https://xXxXxXxXxXxpgbackups.herokuapp.com/client
    REDISCLOUD_URL:             redis://xXxXxXxXxXx:18008
    S3_ACCESS:                  xXxXxXxXxXx
    S3_SECRET:                  xXxXxXxXxXx
    SENDGRID_PASSWORD:          xxxxxxxxx
    SENDGRID_USERNAME:          xxxxxxxxx@heroku.com

Users and permissions
===

The following three concepts are useful to understand permissions:
 * Users
 * Roles
 * Cities

* A User is someone who registered through either the web app or the mobile app. A User can have an optional Facebook ID associated to its record. 
* Roles are associated to Users. A Role can be either `global_admin` or `curator`. A user *without roles* is a "mobile" user. This means that it can log in to the web app but won't be able to do any modification. Users that are created through the mobile app have no role associated. 
* Cities represent the different cities that can be added to the installation, making it virtually unnecessary to deploy different APIs for multiple cities. While a `global_admin` has access to anything in the system, `curator` role needs a city to be associated.

As the app uses `CanCan` to manage permissions, have a look at `app/security/ability.rb` to better understand what users can do depending on their role. 

Creating users, Roles and Cities
---

When the app is first published, no users are defined. Start by creating a new user in the database through the following commands (this will create a `global_admin` role associated to the user) : 

    rails c
    User.new
    u = _
    u.name = "Name"
    u.email = "email@email.com"
    u.password = "the_password"
    u.password_confirmation = "the_password"
    u.skip_confirmation!
    u.roles.build :name => Role::NAMES[0]
    u.save


If you want to create a user with limited privileges:

    u.roles.build :name => Role::NAMES[1]

A user with limited privileges requires a city to be associated in order to be able to make modifications to it:

    u = User.where(email: 'email@email.com').first
    c = City.find(1)
    r = Role.new
    r.name = 'curator'  (or Role::NAMES[1] )
    r.authorizable = c
    r.user = u
    r.save

