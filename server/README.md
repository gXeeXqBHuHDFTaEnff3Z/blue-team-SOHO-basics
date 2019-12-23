### (1) requirements

what should your server be able to serve?

- [ ] [cloud storage](https://www.turnkeylinux.org/nextcloud)
- [ ] [e-mail](https://mailinabox.email/)
- [ ] [DNS Server / Proxy](https://github.com/pi-hole/pi-hole/#one-step-automated-install)
- [ ] [HTTP/HTTPS Proxy](https://discourse.pi-hole.net/t/privoxy-and-pi-hole/70)

### (2) configuration
The configuration should be 
  - infrastructure as code
  - idempotent
  - automatically tested as far as possible

(1) https://www.turnkeylinux.org/ansible
(2) ansible-galaxy install phill93.nextcloud

https://lehrerfortbildung-bw.de/st_digital/netz/virtual/container/docker/index.html
