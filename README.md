# Chromedriver Dockerfile

This is a [Dockerfile](https://docs.docker.com/engine/reference/builder/) to
create a [Webdriver](https://www.w3.org/TR/webdriver/) Docker image with
[ChromeDriver](https://chromedriver.chromium.org/) and
[Google Chrome](https://www.google.com/chrome/).

- [Usage](#usage)
- [Tags](#tags)
- [Software](#software)
- [Configuration](#configuration)
- [License](#license)
- [Author](#author)

## Usage

The `blueimp/chromedriver` image starts a `chromedriver` server on port `4444`,
which runs Webdriver tests with Google Chrome in a virtual X Window System.

Sample [docker-compose](https://docs.docker.com/compose/compose-file/)
configuration:

```yml
version: "3.7"
services:
  chromedriver:
    image: blueimp/chromedriver
    # Mount the /tmp partition as tmpfs:
    tmpfs: /tmp
    environment:
      # Enable the VNC server:
      - ENABLE_VNC=true
      # Expose the X Window Server via TCP:
      - EXPOSE_X11=true
    volumes:
      # Mount the host ./assets directory into the container:
      - ./assets:/home/webdriver/assets:ro
    ports:
      # Expose the VNC server on port 5900 on localhost:
      - 127.0.0.1:5900:5900
```

Please have a look at the [blueimp/wdio](https://github.com/blueimp/wdio)
project for a complete configuration example.

## Tags

For any critical infrastructure (e.g. your company's Continuous Integration
tests) it is **strongly** recommended to use your own tagged Docker images
instead of `blueimp/chromedriver` directly, as changes in the included Software
(see e.g.
[ChromeDriver issue #3857](https://bugs.chromium.org/p/chromedriver/issues/detail?id=3857))
might break your tests inadvertently. For example:

```yml
version: "3.7"
services:
  chromedriver:
    image: YOUR_ORG/chromedriver:2021-09-27
    # ...
```

For full control, you should also set up a build for your own version of
[blueimp/basedriver](https://github.com/blueimp/basedriver) and edit the parent
image reference at the start of the `Dockerfile` in this repository accordingly,
e.g.:

```Dockerfile
FROM YOUR_ORG/basedriver:2021-09-27
```

## Software

The following software is included in the `blueimp/chromedriver` image:

- [blueimp/basedriver](https://github.com/blueimp/basedriver) (base image)
- [ChromeDriver](https://chromedriver.chromium.org/) (latest)
- [Google Chrome](https://www.google.com/chrome/) (latest)

The [blueimp/chromedriver](https://hub.docker.com/r/blueimp/chromedriver) image
provided on Docker hub will be occasionally updated to incorporate changes in
the [blueimp/basedriver](https://github.com/blueimp/basedriver) image as well as
to upgrade to the latest versions of ChromeDriver and Google Chrome.

## Configuration

See
[blueimp/basedriver configuration](https://github.com/blueimp/basedriver/blob/master/README.md#configuration).

## License

Released under the [MIT license](https://opensource.org/licenses/MIT).

## Author

[Sebastian Tschan](https://blueimp.net/)
