FROM ghcr.io/maa123/ffmpeg-docker/qsv/ffmpeg-node:latest AS build

WORKDIR /workspace

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/l3tnun/EPGStation.git --depth 1

WORKDIR /workspace/EPGStation

RUN npm ci && cd client && npm ci && cd ..

RUN npm run build

FROM ghcr.io/maa123/ffmpeg-docker/qsv/ffmpeg-node:latest AS epgstation

RUN apt-get update && apt-get install -y tzdata ca-certificates curl && rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Tokyo

WORKDIR /workspace

COPY --from=build /workspace/EPGStation /workspace/EPGStation