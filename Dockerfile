#
# Chromedriver Dockerfile
#

FROM blueimp/basedriver

# Install chromedriver (which depends on chromium):
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
    chromedriver \
  # Remove obsolete files:
  && apt-get clean \
  && rm -rf \
    /tmp/* \
    /usr/share/doc/* \
    /var/cache/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# Make chromedriver available in the PATH:
RUN ln -s /usr/lib/chromium/chromedriver /usr/local/bin/

# Set CHROMIUM_FLAGS, ignored via chromedriver but used when started manually:
RUN echo 'CHROMIUM_FLAGS=--no-sandbox' >> /etc/chromium.d/default

USER webdriver

CMD ["chromedriver", "--url-base=/wd/hub", "--port=4444", "--whitelisted-ips="]
