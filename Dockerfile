FROM python:3.8

## update core OS packages
RUN apt-get update

# install some helpful packages
RUN apt-get install --assume-yes nodejs npm

## finished updating packages
RUN apt-get autoremove --assume-yes && apt-get clean

## update python libraries and install common dependencies
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install pyyaml requests sqlalchemy flask flask_sqlalchemy

# set up site wide files
WORKDIR "/opt/site/static"
RUN npm install bootstrap jquery --save
RUN mkdir -p /opt/site/html

# set up the application
WORKDIR "/opt/hello"
COPY hello.py /opt/hello/

ENV FLASK_APP hello.py
ENV FLASK_DEBUG 1

EXPOSE 5000

ENTRYPOINT ["/usr/local/bin/python3", "-m", "flask"]
CMD ["run", "--host=0.0.0.0"]

