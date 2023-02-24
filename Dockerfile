FROM python:3.6 AS builder

WORKDIR /usr/src/app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8000

FROM alpine:3.17
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app .
CMD ["gunicorn", "to_do.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]
