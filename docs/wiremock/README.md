# WireMock

Can be used to create a mock `HTTP` server. Comes in handy when integrating with an `API` that has agreed-on contracts but has not been implemented yet.

## Stack

- `Windows 10`
- `Java 8` or later (I'm using the [Microsoft Build of OpenJDK 16.0.1][download-microsoft-openjdk])

## How to

Download `WireMock` from [here][wiremock], rename `wiremock-standalone-*.jar` to `wiremock.jar` for convenience.

| `Java` version | Command |
| --- | --- |
| `8` / `16` | `java.exe -jar .\wiremock.jar --port 9999 --root-dir <path> --print-all-network-traffic` |
| `9` | `java.exe --add-modules java.xml.bind -jar .\wiremock.jar --port 9999 --root-dir <path> --print-all-network-traffic` |

- `--root-dir` where you'll put the files defining the rules and the responses
  - `<path>\mappings` is where you put rules
  - `<path>\__files` is where you can put response bodies
- `--print-all-network-traffic` prints all raw incoming and outgoing network traffic to console, useful if you want to see what's going on

### Stubbing

Documented [here][stubbing].

**Note**: you need to restart `WireMock` when adding a file.

Each rule needs to be in a different file.

#### Inline body

Create a file called `test.json` (the name doesn't matter, only the extension does) in `<path>\mappings`:

```json
{
    "request": {
        "method": "GET",
        "url": "/some/thing"
    },
    "response": {
        "status": 200,
        "body": "Hello world!",
        "headers": {
            "Content-Type": "text/plain"
        }
    }
}
```

#### Load the response body from a file

Create a file called `with-body.json` (the name doesn't matter, only the extension does) in `<path>\mappings`:

```json
{
    "request": {
        "method": "GET",
        "url": "/other/thing"
    },
    "response": {
        "status": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "bodyFileName": "great-body.json"
    }
}
```

Create a file called `great-body.json` (the name matters and has to match the `bodyFileName` property) in `<path>\__files`:

```json
{
    "someProperty": "Hello",
    "anArray": [1, 2, 3],
    "randomObject": {
        "isBoring": true
    }
}
```

[wiremock]: https://wiremock.org/docs/running-standalone/
[stubbing]: https://wiremock.org/docs/stubbing/
[download-microsoft-openjdk]: https://docs.microsoft.com/en-au/java/openjdk/download
