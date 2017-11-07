# Gold Team Track 1 presents Noxio.us

Noxious is a web application that allows users to explore EPA's Toxic Release dataset that is available through Kaggle at https://www.kaggle.com/epa/toxic-release-inventory

## Server Setup

From the provided vm at http://fa17-cs411-42.cs.illinois.edu, which runs CoreOS, we are serving our application using Nginx and Puma to serve a Ruby on Rails for production.

To support development on multiple operating systems, there is a Dockerfile and a docker-compose.yml configuration to support  dockerized development.

The following are some useful commands that will be used in dockerized development.
* `docker-compose build`  - Builds the image described in Dockerfile for the first time
* `docker-compose up` - Composes the web and mysql image, starting the app in development mode at http://localhost:3000
* `docker-compose down` - Gracefully kills app from different terminal window (in same directory)
* `docker-compose run web rails db:create` - Creates the development database
* `docker-compose run web rails db:migrate` - Runs the migrations of the RoR app in the MySQL database
* `docker-compose run web rails generate ...` - Run Rails generate commands like migrations

To run a MySQL client shell:
* `docker-compose run db mysql -uroot -hdb -p`

## Importing Toxic Data

We don't have this figured out yet. We will need a script or something that will read from the csv in chunks and insert them into the dockerized/production MySQL database properly.

### Versions

* Docker 17.09.0-ce (the only thing that needs to be installed on the bare metal)
* Ruby 2.4.2
* Rails 5.1.4
* MySQL latest (5.7.20)

