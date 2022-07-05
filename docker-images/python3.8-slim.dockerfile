FROM python:3.8-slim
LABEL maintainer="Sebastian Ramirez <tiangolo@gmail.com>"

RUN useradd -u 8877 fastapi -m
USER fastapi
COPY requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir --user -r /tmp/requirements.txt
COPY  --chmod=x ./start.sh /start.sh
COPY ./gunicorn_conf.py /gunicorn_conf.py
COPY --chmod=x ./start-reload.sh /start-reload.sh

COPY ./app /app
WORKDIR /app/
ENV PYTHONPATH=/app
EXPOSE 80

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Gunicorn with Uvicorn
CMD ["/start.sh"]
