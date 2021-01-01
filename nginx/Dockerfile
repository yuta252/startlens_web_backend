FROM nginx:1.19.6-alpine

RUN rm -f /etc/nginx/conf.d/*
COPY ./nginx/nginx.conf /etc/nginx/conf.d/startlens.conf
# reboot Nginx after finishing build
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf