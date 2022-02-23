FROM python:3.10.2-alpine3.14
LABEL author="bokkoa"

ENV PYTHONUNBUFFERED 1

# INSTALLING REQUIREMENTS AFTER  COPYING
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user