# guide-how-to-create-a-custom-vending-machine
Works on ARM / i386 / i686 maybe more uses NodeJS 8+
This Guide uses as Backend FeathersJS Rest + Realtime and as Frontend Diffrent DoneJS/CanJS Components and Applications
and as bundler/module loader we use StealJS
- https://stealjs.com
- https://donejs.com
- https://canjs.com
- https://feathersjs.com

## Content
- PrePare Hardware Server (PC)
  - Install Ubuntu LTS 16.04
  - run install-server.sh
    - Installs ssh key less auth (optional)
    - Configure the Firewall (optional)
    - Installs Docker
    - installs couchbase as docker container named database running on host network designed to get secured via network routing
    - installs Backend via Docker NodeJS Latest as container named backend exposes:3030
- PrePare Hardware Client Raspberry PI
- PrePare Hardware Client PC 
- Create a backend using FeathersJS and feathers-couchbase + feathers-dynamic-services
- Create a Frontend for the FeathersJS backend Services
- Diffrent Example UseCases
  - Checkin for Personal in a Room via a Custom Terminal using the NFC Integration
  - Terminal Listing a dataModel like Store Content allow selecting
  - Application to Manage Data from a dataModel normal CRUD Operations
- Integrate CCTalk Protocol Driven Devices
- Integrate Printers (example using TL80) for Printing needs
- Integrate NFC readers for Card Acceptance
- Integrate relay switching (example using node-crelay)
