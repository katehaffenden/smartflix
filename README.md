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

* If we change the default param for an object (ie so that it isn't id - which is the default primary param in rails) then you might also want to change the model to reflect this to (to_param method)
* The method to fetch the api key could be replaced with a private constant in the api adapter.
* Clean  all gem configurations into separate support files, not just vcr and factory_bot
* Correct folder structure so external api files and kept outside of api directory
* omdb api adapter could be made into a class rather than a module [DONE]
* Move logging away from the api_adapter and into a create movie unit/service? Api Adapter may have too many responsibilities right now. [DONE]
