FROM bluenviron/mediamtx:latest-ffmpeg
ARG STREAMPASS
ENV STREAMPASS=${STREAMPASS}

ADD mediamtx.yml /mediamtx.yml
RUN sed -i "s/STREAMPASS/${STREAMPASS}/g" /mediamtx.yml