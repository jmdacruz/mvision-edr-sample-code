FROM python:3.7.4-alpine3.10

RUN pip install pipenv; \
    apk add git libmagic; \
    mkdir /app

COPY Pipfile /app
COPY Pipfile.lock /app
COPY modules /app/modules
WORKDIR /app
RUN pipenv sync

COPY entrypoint.sh /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]