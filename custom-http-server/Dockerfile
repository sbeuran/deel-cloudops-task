FROM python:3.11-slim

WORKDIR /app
COPY . /app

EXPOSE 8080

RUN [ "pip", "install", "-r", "requirements.txt" ]
CMD ["python", "main.py"]