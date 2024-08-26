FROM akashisn/ffmpeg:6.0

WORKDIR /workspace

RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

RUN curl -s https://raw.githubusercontent.com/intel/intel-device-plugins-for-kubernetes/main/cmd/gpu_plugin/render-device.sh -o render-device.sh \
    && chmod +x render-device.sh \
    && ./render-device.sh

RUN ffmpeg -f lavfi -i testsrc=duration=10:size=1280x720:rate=30 /workspace/input.mp4

RUN echo '#!/bin/bash\n\
vainfo\n\
ffmpeg -init_hw_device qsv:hw -hwaccel qsv -hwaccel_output_format qsv -i /workspace/input.mp4 -c:v h264_qsv /workspace/output.mp4\n\
echo "Intel QSV encoding complete!"' > /test_qsv.sh \
    && chmod +x /test_qsv.sh
