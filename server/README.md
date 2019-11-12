### (1) requirements

what should your server be able to serve?

- [ ] [cloud storage](https://docs.hanssonit.se/s/W6fMouPiqQz3_Mog/virtual-machines-vm/d/W6fMquPiqQz3_Moi/nextcloud-vm)
- [ ] [e-mail](https://mailinabox.email/)
- [ ] [DNS Server / Proxy](https://github.com/pi-hole/pi-hole/#one-step-automated-install)
- [ ] [HTTP/HTTPS Proxy](https://discourse.pi-hole.net/t/privoxy-and-pi-hole/70)

### (2) architecture
if you checked more than one box above, it's probably a good idea to use virtual servers for each of them:

https://xenproject.org/downloads/xen-project-archives/xen-project-4-12-series/

https://www.ip-insider.de/citrix-xenserver-und-hypervisor-in-der-praxis-a-791323/

### (3) configuration
The configuration should be 
  - infrastructure as code
  - idempotent
  - automatically tested as far as possible

https://www.redhat.com/en/blog/system-administrators-guide-getting-started-ansible-fast
