# Splunk

This guide will help you to run `Splunk` locally and configure a `HTTP Event Collector`.

## Prerequisites

- [Docker][docker-community-edition]

## Docker Compose

Create a file named `docker-compose.yml`:

```yaml
version: '3'

volumes:
  opt-splunk-etc:
  opt-splunk-var:

services:
  splunk:
    hostname: localhost
    image: splunk/splunk:7.0.2
    environment:
      SPLUNK_START_ARGS: --accept-license --answer-yes
    volumes:
      - opt-splunk-etc:/splunk/etc
      - opt-splunk-var:/splunk/var
    ports:
      - "8000:8000"
      - "8088:8088"
```

**Note**: I only care about opening the ports for the portal (`8000`) and the `HTTP Event Collector` (`8088`). Your requirements may vary.

Then in the directory where you created this file:

```posh
docker-compose up
```

## Configure Splunk

### Create an `index`

I recommend creating an `index` as it is the easiest way to discard events when you don't need them anymore.

![Create index #1](assets/create-index-1.png)

![Create index #2](assets/create-index-2.png)

![Create index #3](assets/create-index-3.png)

![Create index #4](assets/create-index-4.png)

### `Data inputs`

![Add Data inputs](assets/add-data-inputs.png)

### Add a `HTTP Event Collector`

![Add HTPP Event Collector](assets/add-http-event-collector.png)

### Configure the `HTTP Event Collector`

Name your `Collector`:

![Configure HTPP Event Collector #1](assets/configure-http-event-collector-1.png)

On the second page, select the default `index`:

![Configure HTPP Event Collector #2](assets/configure-http-event-collector-2.png)

### Enable the token

By default `Collectors` are disabled.

![Enable tokens #1](assets/enable-token-1.png)

![Enable tokens #2](assets/enable-token-2.png)

- Enable `All Tokens`
- Uncheck `Enable SSL`
- Set the `HTTP Port Number` - you should set this to `8088` or whatever value you used in `docker-compose.yml`

![Enable tokens #3](assets/enable-token-3.png)

[docker-community-edition]: https://www.docker.com/community-edition#/download
