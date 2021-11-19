FROM python:3.9.2-alpine3.13

# Build-time flags
ARG WITH_PLUGINS=true

# Environment variables
ENV PACKAGES=/usr/local/lib/python3.9/site-packages
ENV PYTHONDONTWRITEBYTECODE=1

# Set build directory
WORKDIR /tmp

# Copy files necessary for build
COPY material material
COPY MANIFEST.in MANIFEST.in
COPY package.json package.json
COPY README.md README.md
COPY requirements.txt requirements.txt
COPY setup.py setup.py
COPY fonts /usr/share/fonts/Additional

# Perform build and cleanup artifacts and caches
# set mirros for apline and python plugins
RUN \
  sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
&& \
  apk upgrade --update-cache -a \
&& \
  apk add --no-cache \
    git \
    git-fast-import \
    openssh \
    # WeasyPrint
    pango zlib-dev jpeg-dev openjpeg-dev g++ libffi-dev \
    # Headless Chrome
    udev chromium\
    # font
    fontconfig ttf-freefont font-noto terminus-font \
&&  \
  chromium-browser --version \
&& \
  fc-cache -f \
&& \
  fc-list | sort \
&& \
  apk add --no-cache --virtual .build \
    gcc \
    musl-dev \
&& \
  pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/ \
&& \
  pip install --no-cache-dir . \
&& \
  sed -i 's/tag.text/tag.string/g' /usr/local/lib/python3.9/site-packages/mkdocs_with_pdf/generator.py  \
&& \
  if [ "${WITH_PLUGINS}" = "true" ]; then \
    pip install --no-cache-dir \
      "mkdocs-minify-plugin>=0.3" \
      "mkdocs-redirects>=1.0"; \
  fi \
&& \
  apk del .build \
&& \
  for theme in mkdocs readthedocs; do \
    rm -rf ${PACKAGES}/mkdocs/themes/$theme; \
    ln -s \
      ${PACKAGES}/material \
      ${PACKAGES}/mkdocs/themes/$theme; \
  done \
&& \
  rm -rf /tmp/* /root/.cache \
&& \
  find ${PACKAGES} \
    -type f \
    -path "*/__pycache__/*" \
    -exec rm -f {} \;

# Set working directory
WORKDIR /docs

# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
# ENTRYPOINT ["mkdocs"]
# CMD ["serve", "--dev-addr=0.0.0.0:8000"]
