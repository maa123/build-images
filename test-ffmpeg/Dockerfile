FROM akashisn/ffmpeg:6.0

WORKDIR /workspace

RUN ffmpeg -f lavfi -i testsrc=duration=10:size=1280x720:rate=30 /workspace/input.mp4

RUN echo '#!/bin/bash\n\
vainfo\n\
ffmpeg -init_hw_device qsv:hw -hwaccel qsv -hwaccel_output_format qsv -i /workspace/input.mp4 -c:v h264_qsv /workspace/output.mp4\n\
echo "Intel QSV encoding complete!"' > /test_qsv.sh \
    && chmod +x /test_qsv.sh
