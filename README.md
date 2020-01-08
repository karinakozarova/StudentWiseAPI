# StudentWise API
[![Pipeline Status](https://git.fhict.nl/I433762/studentwise-api/badges/master/pipeline.svg)](https://git.fhict.nl/I433762/studentwise-api/commits/master)

This repository contains the RESTful API for StudentWise developed with Ruby on Rails.

## Introduction:
StudentWise is a solution aimed towards students living in shared accommodation.
It allows for tracking events in the building and managing the joint expenses.
This application also enables the monitoring of environmental conditions in the common area.
Additionally, users can file complaints to the management.

## Prerequisites:
* Docker - [Installation guide](https://docs.docker.com/install/#supported-platforms)
* Docker Compose - [Installation guide](https://docs.docker.com/compose/install/)

## How to set up locally?
1. Clone the repository.
	```
	$ git clone https://git.fhict.nl/I433762/studentwise-api.git
	```
1. Enter **studentwise-api** project directory.
	```
	$ cd studentwise-api
	```
1. Run docker containers in detached mode. This can take a while as the docker image has to be built for the first time.
	```
	$ sudo docker-compose up -d
	```
1. Set up the database.
	```
	$ sudo docker exec studentwise-api rails db:setup
	```
1. Adjust the permissions to `tmp/db` folder. If you skip this step, you won't be able to rebuild the docker image in the future.
	```
	$ sudo chown -R $USER:$USER tmp/db
	```
1. Access **StudentWise API** through the browser.

	[Click here to open StudentWise API](http://localhost:3000/)

## Development:
If you want to see the output from Rails server, run `docker-compose up` command without `-d` argument.

---

If you modified Gemfile, make sure to rebuild the docker image:
1. If docker containers are running, stop them: `sudo docker-compose down`.
2. Rebuild docker image and run containers again: `sudo docker-compose up --build -d`.
