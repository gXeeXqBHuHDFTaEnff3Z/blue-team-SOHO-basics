# How to setup a network from scratch

### (1) functional requirements: what do your users want to do?
- [ ] communicate via e-mail / chat
- [ ] communicate via landline / mobile phone
- [ ] internet access via browser
- [ ] data storage for...
  - documents
  - pictures / videos
- [ ] printing
- [ ] cloud services
- [ ] other requirements

### (2) operational requirements: what will be needed for this to work?
- [ ] systems oberservability / monitoring
- [ ] remote and central management
- [ ] software upgrades
- [ ] administration and support
- [ ] backup and recovery strategy

### (3) inventory: what do you have?
- [ ] make table of all hardware devices
- [ ] make table of all used software and their sources
- [ ] make table of all used cloud accounts (in password manager)
- [ ] [draw](https://www.draw.io/) a network diagram with
  - compartmentalization
    - IP subnet(s)
    - DMZ
  - devices inlcuding name and ip (or dhcp range)
    - firewall / internet gateway
    - switch / wireless AP
    - servers
    - client
    
### (4) secure configurations: how do you set it up?
- [ ] secure configuration per device using [TTP.csv](https://github.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/blob/master/TTP.csv)
- [ ] secure configuration per user using [TTP.csv](https://github.com/gXeeXqBHuHDFTaEnff3Z/blue-team-SOHO-basics/blob/master/TTP.csv)
- [ ] verify connfigurations

### (5) user training: what do users need to know?
- [ ] how to boot encryped devices
- [ ] how to unlock devices/user account
- [ ] how to use 2FA
- [ ] how to use password manager
- [ ] how to regularly create an encrypted offline backup
- [ ] whom to call on incident response and HaveIBeenPwned notifications
- [ ] [Signal contact verification](https://support.signal.org/hc/en-us/articles/360007060632-What-is-a-safety-number-and-why-do-I-see-that-it-changed-)


    
  
