Habakuk Credentials Client
==========================

Client library for the Habakuk Credentials Service.

Install
-------

    npm install --save git+ssh://git@github.org:yocondo/habakuk-credentials-client.git

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

Logging
-------

By default the service logs to `console.log`. If you want to use a logging framework, simply set the property `logger` to an object that can receive calls to the methods `debug`, `info`, `warn` and `error`.

    var credentialsClient = require('habakuk-credentials-client');
    credentialsClient.logger = require('winston');
    
    var options = {};
    var credentials = credentialsClient(options);
