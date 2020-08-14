FROM python:3.8

## update core OS packages
RUN apt-get update

# install some helpful packages
RUN apt-get install --assume-yes nodejs npm

## finished updating packages
RUN apt-get autoremove --assume-yes && apt-get clean

## update python libraries and install common dependencies
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install pyyaml requests sqlalchemy flask flask_sqlalchemy flask-wtf

# set up site wide files
WORKDIR "/opt/site/static"
COPY static .

ADD https://code.jquery.com/jquery-3.5.1.min.js ./js/jquery.js
ADD https://unpkg.com/@popperjs/core@2 ./js/popper.js
ADD https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css ./css/bootstrap.css
ADD https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js ./js/bootstrap.js

WORKDIR "/opt/site/static/icons/bootstrap"
ADD https://github.com/twbs/icons/releases/download/v1.0.0-alpha5/bootstrap-icons-1.0.0-alpha5.zip /tmp/bootstrap-icons.zip
RUN unzip -j /tmp/bootstrap-icons.zip && rm -f /tmp/bootstrap-icons.zip

RUN mkdir -p /opt/site/html

# set up the application
WORKDIR "/opt/hello"
COPY hello.py /opt/hello/

ENV FLASK_APP hello.py
ENV FLASK_DEBUG 1

EXPOSE 5000

ENTRYPOINT ["/usr/local/bin/python3", "-m", "flask"]
CMD ["run", "--host=0.0.0.0"]

