FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential python2.7-dev
RUN apt-get install -y libpq-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev
RUN apt-get install -y libmemcached-dev zlib1g-dev 
RUN apt-get install -y zlib1g-dev libssl-dev python-dev build-essential
COPY . /app
WORKDIR /app
RUN pip install flask
RUN pip install pylibmc==1.2.3
ENTRYPOINT ["python"]
CMD ["app.py"]
