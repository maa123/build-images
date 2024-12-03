FROM python:3.11-slim AS builder

WORKDIR /app

RUN pip install --upgrade pip

COPY requirements.txt .

RUN pip install -r requirements.txt --user --no-cache-dir

RUN pip install --no-cache-dir --user torch==2.5.1+cpu torchvision==0.20.1+cpu --index-url https://download.pytorch.org/whl/cpu

FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /root/.local /root/.local
