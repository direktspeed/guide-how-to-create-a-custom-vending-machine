# guide-how-to-create-a-custom-vending-machine
Works on ARM / i386 / i686 maybe more uses NodeJS 8+
This Guide uses as Backend FeathersJS Rest + Realtime and as Frontend Diffrent DoneJS/CanJS Components and Applications
and as bundler/module loader we use StealJS
- https://stealjs.com
- https://donejs.com
- https://canjs.com
- https://feathersjs.com

## What you will learn
In this guide you will learn about all DoneJS and FeathersJS features by creating, testing, documenting, building and deploying Custom Terminal Applications that are using a single FeathersJS driven Backend, The final result will look like this:

** ScreenShoot **

After the initial application setup, which includes a server that hosts and pre-renders the application, we will create several custom elements and bring them together using the application state and routes. Then we will learn how to retrieve data from the server using a RESTful API.

After that we will talk about what a view model is and how to identify, implement and test its functionality. Once we have unit tests running in the browser, we will automate running them locally from the command line and also on a continuous integration server. In the subsequent chapters, we will show how to easily import other modules into our application and how to set up a real-time connection.

Finally, we will describe how to build and deploy our application

1. if you don't have installed donejs follow
https://donejs.com/SettingUp.html
2. if you don't have installed feathers follow
https://docs.feathersjs.com/guides/readme.html => https://docs.feathersjs.com/guides/step-by-step/generators/readme.html

3. Clone this repository it Contains 
- backend/ => the full backend code
- frontends/ => diffrent frontend examples that get all directly served by the backend
4. go into the folder with cd
5. npm install => runs npm install in frontends and backend
6. to understand the Frontend Parts follow https://donejs.com/place-my-order.html its a example application like this using a FeathersJS Backend.




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



## Use drivers
```
npm install -g <package.name>
cp $(npm root -g)/<package.name>/config.example.js $(npm root -g)/<package.name>/config.js
edit $(npm root -g)/<package.name>/config.js

# Run via systemctl
systemctl enable $(npm root -g)/<package.name>/<package.name>.service
systemctl start <package.name>

# Run via docker (Optional)
```

## Drivers NPM <package.name>
- feathers-nfc-pcsc
- feathers-cctalk
- feathers-printer
- feathers-crelay

## Backend Components
- See package.json
