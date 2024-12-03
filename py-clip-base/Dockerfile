FROM python:3.11-slim AS builder

WORKDIR /app

RUN pip install --upgrade pip

COPY requirements.txt .

RUN pip install -r requirements.txt --user --no-cache-dir

FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /root/.local /root/.local
