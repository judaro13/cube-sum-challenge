# Cube summation challenge

This is a implementation for the Cube Summation challenge in Ruby using a simple router for web development called Syro.
https://www.hackerrank.com/challenges/cube-summation/problem


# Installation

This installation guide is made for Linux machines. Be sure you have previously installed  a Ruby version bigger than 1.8

## Gems

This project need the gems specified in the Gemfile file, to install it use the command (in your command line console)

    bundle install

if you don't have installed the gem bundle, would be rise a error, to fix it install it with the command:

    gem install bundle

## Execution

To facilitate the execution we use the rack server shotgun https://github.com/rtomayko/shotgun
Being inside the project, type in your command line

    shotgun
This project was configured to work in the port 9393, so be sure that the web app is running there. After the server start, you be able to use the web app; go to your browser and open the url localhost:9393 or 0.0.0.0:9393 (this depend of your system configurations)

# Architecture

This project is divided in 4 big sections:
### Main root
In the main root of the project are stored the configuration files of the project, that include:

**file config.ru**: Web server configuration file. This is the main file of the project, here are specified the gem used and routes for the web app.
This project work as a self **API** that have 3 endpoints:

*get /*  -> This render the index template and show web app UI.

*post /*  -> Receive a parameter called "matrix" and generate a initial matrix with the given size

*post /operation*  ->  Receive as parameters "data" that is the operation to realize (update or query),  "matrix" that is the previous matrix generated and "size" that is the current size of the matrix used.

To process any operation from the web application, the Cube class receive an initial value "size" and generate a initial matrix, then is loaded the previous matrix and applied the new operation and returned the results; with "update" operation is returned the new matrix generated and with "query" operation is returned the sum value. This behavior is needed the keep the app stateless.

**files Gemfile Gemfile.lock**: This files specified the gem needed and the version

**file readme.md**: This file


### Lib folder

This folder contains the Cube and Web classes where:

**cube .rb** Have the ruby implementation of the cube summation challenge, this especified the Cube class that implement a matrix of N x N x N and the operation defined in the challenge.  
The matrix was represented by  and Array of Array of Array where the first array represent the coordinate Z, the second the coordinate X and the last the coordinate Y.
The sum operation was made with an iteration over the array in the sections specified in the given points.

**web_deck .rb** This file have defined the class Web that is a Web Deck for Syro and the templates that will be use to render the web application.

### Views folder
This folder contains the mote templates for the views of the web application splitted by the routes displayed.

**layout .mote**  Specified the main layout of the web application and is used Bootstrap to stylize the application.

**index .mote**  This file have the JavaScript functions for handle the index view, here was made JS validations for the restrictions given in the challenge to send the values to the self application.

### Test folder
Contains all the test generated over the class Cube to validate the solution of the Cube Summation Challenge.
For execute the test just run in your command line

    ruby test/cube_test.rb
