Habakuk Credentials Client
==========================

Client library for the Habakuk Credentials Service.

Install
-------

    npm install --save git+ssh://git@bitbucket.org:yocondo/habakuk-credentials-client.git

Usage
-----

    var options = {};
    var credentials = require('habakuk-credentials-client')(options);
    credentials.get().then(function(c) {
    	console.log('loaded credentials:', c);
    }, function(err) {
    	console.log('error loading credentials:', err.stack || err);
    });

Options
-------

* `host` (optional): The hostname of the credentials server. Can include a port. Default: `credentials.habakuk.yocondo.de`
* `type` (required): The type of credentials to load, e.g. `amazon.de` or `de.dawanda.com`
* `clientId` (required): A unique identifier for this client, e.g. `amazon-crawler_heroku-01`
