FROM jesshaw/markdocs-matertial-plantuml-pdf:1.0 as builder
MAINTAINER jes
WORKDIR /docs
COPY  / /docs

RUN \
  mkdocs build ;

# CMD ["mike","serve","--dev-addr=0.0.0.0:8000"]

FROM nginx:1.19.2
COPY --from=builder  /docs/site /usr/share/nginx/html
# COPY --from=builder  /docs/nginx.conf /etc/nginx/

#
# build images
#
# docker build -t jesshaw/mynotes -f mynotes.Dockerfile  .
# 
# checkl
# 
# docker run --rm -it -p 8000:80 jesshaw/mynotes