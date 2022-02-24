FROM python:3.10.2-alpine3.14
LABEL author="bokkoa"

ENV PYTHONUNBUFFERED 1

# INSTALLING REQUIREMENTS AFTER  COPYING
COPY ./requirements.txt /requirements.txt

# INSTALL POSTGRESQL CLIENT
RUN apk add --update --no-cache postgresql-client

# Virtual for dependencies that can be removed later
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev

RUN pip install -r /requirements.txt

# Cleaning dependencies
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user