# Smartflix

### Description ###

Smartflix is a practice project to experiment with Ruby and Rails. The project currently uses the OMDB API to fetch information for films which it then adds to the database. The information can then be accessed and manipulated via the app. At the moment the project consists of a movie model, controller adapter to interact with the OMDB api and a sidekiq worker.   

### Setup ###

To setup the app locally, clone the repo and run:
``bundle``
then
``bin/setup rails/s`` to run the server. To see a movie listing visit the url: localhost:3000/movies/:title

### Tests ###
In the root directory run the following command to run all tests:
``rspec``

### Possible improvements ###

* Add a unit that handles the creation of a movie
* Edit the inclusion of title in the create movie worker so the worker can be ran and generate a movie of its own.
