# CoreDNS

CoreDNS is a DNS server. It is written in Go. It can be used in a multitude of
environments because of its flexibility.

CoreDNS chains plugins. Each plugin performs a DNS function, such as Kubernetes
service discovery, Prometheus metrics or rewriting queries.

coredns.io

<img src="https://camo.githubusercontent.com/5e71d7e8874e1f00bd8c01874c1c63976ce7da870e2178c62c5f6af152c8ccb8/68747470733a2f2f692e6962622e636f2f35676679327935672f636f7265646e732e6a7067" width="30%" height="auto" alt="CoreDNS logo">

## How to use this Makejail

```console
$ appjail oci run -Pd \
    -o overwrite=force \
    -o virtualnet=":<random> default" \
    -o nat \
    ghcr.io/appjail-makejails/coredns coredns \
    -dns.port=1053
...
$ appjail jail list -j coredns name network_ip4
NAME     NETWORK_IP4
coredns  10.0.0.8
```

Once you have a `coredns` binary, you can use the `-plugins` flag to list all the compiled plugins. Without a `Corefile` (See [Configuration](https://coredns.io/manual/toc/#configuration)) CoreDNS will load the [whoami](https://coredns.io/plugins/whoami) plugin that will respond with the IP address and port of the client. So to test, we start CoreDNS to run on port 1053 and send it a query using [`dig`](https://freshports.org/dns/bind-tools):

```console
$ dig @10.0.0.8 -p 1053 a whoami.example.org

; <<>> DiG 9.20.24 <<>> @10.0.0.8 -p 1053 a whoami.example.org
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 39862
;; flags: qr aa rd; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 3
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 849c8d65a4784b81 (echoed)
;; QUESTION SECTION:
;whoami.example.org.		IN	A

;; ADDITIONAL SECTION:
whoami.example.org.	0	IN	A	10.0.0.1
_udp.whoami.example.org. 0	IN	SRV	0 0 42695 .

;; Query time: 0 msec
;; SERVER: 10.0.0.8#1053(10.0.0.8) (UDP)
;; WHEN: Mon Jul 27 20:53:46 -04 2026
;; MSG SIZE  rcvd: 135

```

### Arguments (stage: build)

* `coredns_from` (default: `ghcr.io/appjail-makejails/coredns`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `coredns_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).

### Environment (OCI image)

* `PGID` (default: `1000`): Equivalent to `PUID` but for the Process Group ID.
* `PUID` (default: `1000`): Process User ID for the container's main process, allowing you to match the owner of files written to mounted host volumes to your host system's user. Writable volumes are changed based on this environment variable.

## OCI Configuration

```yaml
build:
  variants:
    - tag: 15.1
      containerfile: Containerfile
      aliases: ["latest"]
      default: true
      args:
        FREEBSD_RELEASE: "15.1"
        NO_PKGCLEAN: "1"
      cache_dirs: ["pkgcache0:/var/cache/pkg"]
```
