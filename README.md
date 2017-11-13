# Gold Team Track 1 presents Noxio.us

Noxious is a web application that allows users to explore EPA's Toxic Release dataset that is available through Kaggle at https://www.kaggle.com/epa/toxic-release-inventory

View our Wiki page here: https://wiki.illinois.edu/wiki/pages/viewpage.action?spaceKey=~jcao7&title=Gold+Team

## Dev setup
Only once, download the Docker app, and run the following:
```bash
git clone https://github.com/trueb2/GoldTeamTrack1.git
cd GoldTeamTrack1
docker-compose build
```

Visit https://www.kaggle.com/epa/toxic-release-inventory and download the dataset, putting basic_data_files.csv in GoldTeamTrack1/. To create and fill the database, run the following:
```bash
docker-compose run web rails db:create  # Creates the tables in MySQL if they don't exist
docker-compose run web rails db:migrate # Applies migrations (Rails-specific way of
                                        # editing table structure)
docker-compose run web rails db:seed    # Parses CSV file into database (progress updates
                                        # periodically, ctrl-C when you have enough records)
```

To run the application:
```bash
# May need to follow database creation steps above if it can't find the database
docker-compose up
# Open localhost:3000 in a browser
```

To stop the application:
```bash
docker-compose down
```

Edit files directly in GoldTeamTrack1 (on your local machine). Docker images share files with your local machine, so don't worry about that.

## Other helpful commands
Runs rails commands in Docker image:
* `docker-compose run web rails <rails command>`
Launch a MySQL client shell, to inspect data (root password is root):
* `docker-compose run db mysql -uroot -hdb -p`

## Project details

From the provided vm at http://fa17-cs411-42.cs.illinois.edu, which runs CoreOS, we are serving our application using Nginx and Puma to serve a Ruby on Rails for production.

To support development on multiple operating systems, there is a Dockerfile and a docker-compose.yml configuration to support  dockerized development.

## Deploying on production server

Read notes in /home/shared/README on production server (http://fa17-cs411-42.cs.illinois.edu).

## Other notes

Extra MacOS setup if you don't have Docker.app:
* `docker-machine start # Start virtual machine for docker`
* `docker-machine env  # It's helps to get environment variables`
* `eval "$(docker-machine env default)" # Set environment variables`

### Versions

* Docker 17.09.0-ce (the only thing that needs to be installed on the bare metal)
* Ruby 2.4.2
* Rails 5.1.4
* MySQL latest (5.7.20)

