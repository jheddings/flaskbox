# FlaskBox #

Containerized Flask application framework.

## Building ##

Build the container using `make build`.  This will install several helpful packages and
Python libraries in the application environment.

## Running ##

To invokve the container, simply run `make run` from the base directory.  The sample
application will be available at http://localhost:5000

## Customizing ##

Containers are expected to provide their own application files, typically in a new folder
under `/opt`.

The following locations are considered "site wide" files, which can be used where
appropriate.

* /opt/site/html - location for application templates
* /opt/site/static - location for static application files
