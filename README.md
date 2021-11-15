# Smartflix

### Description ###

Smartflix is a practice project to experiment with Ruby and Rails. The project currently uses the OMDB API to fetch movie data which it then adds to a database. The information can then be accessed and manipulated via the app. At the moment the project consists of:
 * a movie model
 * a movie controller (for the movie endpoint)
 * an adapter for the omdb_api
 * a create movie sidekiq worker that handles the async handoff to the create movie unit
 * a create movie unit which handles the creation of a movie
 * an update movie unit to update movies records that exist in the database
 * a batch update movie worker which runs everyday at 7am making to update existing movies in the database
 * a update single movie worker which takes a single movie and sends it to the update movie unit to be updated
 * a destroy movie worker which runs everyday at 8am, removing movies that have not been updated in 48 hours
 * specs for all of the above

### Setup ###

NOTE: the password for the database will need to be replaced in the `init.sql` file to a password of your choice before the application is built with docker. The password currently supplied to docker for the database's user includes a dummy reference to the POSTGRES_PASSWORD ENV variable. 

To setup the app locally, clone the repo, update the `init.sql` file and run:
``docker-compose build``
then
``docker-compose up`` to run the application.

To setup the database when you boot the application run:

``docker-compose run web rails db:create``

``docker-compose run web rails db:migrate``

To see a movie listing visit the url: `localhost:3000/movies/:title`
To view all movies visit `localhost:3000/movies`

To shut down the application:

``docker-compose down``

### Tests ###
In the root directory run the following command to run all tests:
``rspec``

### Improvements ###

* Gem configurations have been moved into separate support files within the support folder.
* Folder names have been updated to the plural.
* Data formatting is handled in the api wrapper.
* Base action has been moved to the unit folder.
* Calls to the API were moved to the units.
* Chosen a unit test approach for workers and units. Repetitive integration specs were removed. 
* Batch and single update movie worker created to make the update process more efficient 
