# Smartflix

### Description ###

Smartflix is a practice project to experiment with Ruby and Rails. The project currently uses the OMDB API to fetch information on movies which it then adds to a database. The information can then be accessed and manipulated via the app. At the moment the project consists of:
 * a movie model
 * a movie controller
 * a sidekiq worker that handles the async handoff to the create movie unit
 * an adapter for the omdb_api
 * a create movie unit which handles the creation of a movie

### Setup ###

To setup the app locally, clone the repo and run:
``bundle``
then
``bin/setup rails/s`` to run the server. To see a movie listing visit the url: localhost:3000/movies/:title

### Tests ###
In the root directory run the following command to run all tests:
``rspec``

### Possible improvements ###

* Clean  all gem configurations into separate support files, not just vcr and factory_bot
* Correct folder structure so external api files and kept outside of api directory
* omdb api adapter could be made into a class rather than a module [DONE]
* Move logging away from the api_adapter and into a create movie unit/service? Api Adapter may have too many responsibilities right now. [DONE]
* Instead of having the update movie unit inherit from create movie action there could be a base action that both of the individual actions in each unit inherit from. To avoid repetition
* Equally both workers could access omdb adapter via dry mixin containers/ dependencies rather than repeated private methods.
* Use cassettes in entry_point specs so they are more like integration tests and not repetitive unit tests
