# LwIP Echoserver (lwip-echoserver)

This repository illustrates how to create a simple TCP echo server with the lightweight TCP/IP (lwIP) stack on a Linux host.

* The program leverages the user-space TCP/IP stack provided by lwIP

* The solution is based on the `tcpecho_raw` example of LwIP, which uses the "raw" API of lwIP

* The application logic of the example does not require a socket interface (`NO_SYS` is set to 1)

* The TCP echo server can be accessed locally on a Linux host by a `tap0` interface

References:

* The example uses the stable release 2.1.3 of [LwIP]

* The build system is partly based on a lwIP [fork]

Contact: michael.scharf@ktlab.de

## Usage

### Prerequisits

* Installation requires a Linux operating system (e.g., Debian)

* The `ifconfig` tool must be installed (e.g., the package `net-tools` on Debian)

* Build tools for the C programming language must be installed (i.e., `gcc`, `make`, etc.)

* Root privileges are required for running the TCP echo server (e.g., by `sudo`)

### Compilation and start

Compilation on Linux in the project directory:

```bash
make
```

Afterwards, the binary for the echoserver can be found in `bin/echoserver`.

### Usage

The server can be started with root priviliges:

```bash
sudo bin/echoserver
```

In the default configuration, the TCP echo server uses a local `tap0` interface:
* IP address: 192.168.1.1
* Port number: 60000

Any text client can access the echo server locally, e.g., the Linux tool `nc`:

```bash
nc 192.168.1.1 60000
```

### Visual Studio Code Integration

Instead of manually running `make`, the project can also be compiled in
Visual Studio Code (vscode).

To simplify use, the `run` command (e.g., assigned to the key F5) runs
the echo server binary.


[lwIP]: https://savannah.nongnu.org/projects/lwip/
[fork]: https://github.com/heiher/lwip

