FROM python:3.10-alpine

ENV PYTHONUNBUFFERED=1

WORKDIR /
COPY ./app /app
COPY ./requirements.txt /

RUN pip install -r requirements.txt

# CMD ["ls"]
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0"]
