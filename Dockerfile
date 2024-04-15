FROM tiangolo/nginx-rtmp:latest-2024-03-25
ARG ENDPOINT
ENV ENDPOINT=${ENDPOINT}

ADD nginx.conf /etc/nginx/nginx.conf
RUN sed -i "s/ENDPOINT/${ENDPOINT}/g" /etc/nginx/nginx.conf