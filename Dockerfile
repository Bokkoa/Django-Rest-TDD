FROM python:3.10.2-alpine3.14
LABEL author="bokkoa"

ENV PYTHONUNBUFFERED 1

# INSTALLING REQUIREMENTS AFTER  COPYING
COPY ./requirements.txt /requirements.txt

# INSTALL POSTGRESQL CLIENT
RUN apk add --update --no-cache postgresql-client jpeg-dev

# Virtual for dependencies that can be removed later
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

RUN pip install -r /requirements.txt

# Cleaning dependencies
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Directories for images
RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

RUN adduser -D user

# Permissions for docker user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web

USER user