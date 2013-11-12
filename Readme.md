Preinstall:
    Make sure you have installed node.js, coffee and bower
        1. node.js:nodejs.org
        2. sudo npm install coffee-script -g
        3. sudo npm install bower -g

Install:

    git clone https://github.com/runawaygo/CodingDojo-Dashboard.git
    cd CodingDojo-Dashboard
    npm install
    bower install

Start:

    coffee server.coffee

Open url in browser: 

    127.0.0.1:9000

Add repo:

    mkdir repos
    cd repos
    git clone https://github.com/runawaygo/CodingDojo.git

Open url in browser: 

    127.0.0.1:9000?repo=CodingDojo&branches=start,superwolf

