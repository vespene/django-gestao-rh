FROM python:3.8-alpine

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PIPENV_VENV_IN_PROJECT 1
ENV PATH ./.venv/bin:$PATH

RUN pip install --upgrade pip
RUN pip install pipenv

RUN apk add --update --no-cache postgresql-client jpeg-dev zlib zlib-dev \
        libffi-dev gcc libc-dev linux-headers postgresql-dev

RUN addgroup -S djangoapp && adduser -S djangoapp -G djangoapp
RUN mkdir /app
RUN chown djangoapp:djangoapp /app

WORKDIR /app

COPY --chown=djangoapp ./Pipfile* /app/
COPY --chown=djangoapp ./src/ /app/

USER djangoapp

RUN pipenv --python 3.8
RUN pipenv sync
RUN /app/.venv/bin/pip3 install --upgrade pip

RUN mkdir /app/log

CMD gunicorn gestao_rh.wsgi:application --bind 0.0.0.0:$PORT
