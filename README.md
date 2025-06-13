# CoreDNS

CoreDNS is a DNS server. It is written in Go. It can be used in a multitude of environments because of its flexibility.

CoreDNS chains plugins. Each plugin performs a DNS function, such as Kubernetes service discovery, Prometheus metrics or rewriting queries.

coredns.io

<img src="https://i.ibb.co/5gfy2y5g/coredns.jpg" alt="coredns logo" width="30%" height="auto">

## How to use this Makejail

```sh
appjail makejail \
    -j coredns \
    -f gh+AppJail-makejails/coredns \
    -o virtualnet=":<random> default" \
    -o nat \
    -o expose=53
```

### Arguments

* `coredns_ajspec` (default: `gh+AppJail-makejails/coredns`): Entry point where the `appjail-ajspec(5)` file is located.
* `coredns_tag` (default: `13.5`): see [#tags](#tags).

## Tags

| Tag           | Arch    | Version            | Type   |
| ------------- | --------| ------------------ | ------ |
| `13.5`    | `amd64` | `13.5-RELEASE` | `thin` |
| `14.3`    | `amd64` | `14.3-RELEASE` | `thin` |
