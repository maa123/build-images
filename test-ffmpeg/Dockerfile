FROM ghcr.io/maa123/ffmpeg-docker/qsv/ffmpeg:latest

WORKDIR /workspace

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN ffmpeg -f lavfi -i testsrc=duration=10:size=1280x720:rate=30 /workspace/input.mp4

RUN echo '#!/bin/bash\n\
vainfo\n\
ffmpeg -init_hw_device qsv:hw -hwaccel qsv -hwaccel_output_format qsv -i /workspace/input.mp4 -c:v h264_qsv /workspace/output.mp4\n\
echo "Intel QSV encoding complete!"' > /test_qsv.sh \
    && chmod +x /test_qsv.sh
