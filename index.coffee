{ Promise } = require 'es6-promise'
rest = require 'restler'

defaultOptions =
	host: 'credentials.habakuk.yocondo.de'

service = (options) ->
	options[key] ?= value for key, value of defaultOptions
	throw new Error 'error creating habakuk credentials client: options must contain the credentials type as "type"' unless options.type
	throw new Error 'error creating habakuk credentials client: options must contain the client ID as "clientId"' unless options.clientId

	credentials = null

	timeout = null

	clearCredentials = ->
		service.logger.info '[habakuk] credentials have expired'
		credentials = null
		timeout = null

	loadCredentials = ->
		credentials = new Promise (resolve, reject) ->
			url = "http://#{options.host}/lease/#{options.type}/#{options.clientId}"
			service.logger.info '[habakuk] loading credentials from', url
			clearTimeout timeout if timeout
			req = rest.get url
			req.on 'error', reject
			req.on 'fail', (data, response) ->
				service.logger.info '[habakuk] could not get credentials (status %d), retrying in %d seconds', response.statusCode, data.retryAfter
				setTimeout loadCredentials, data.retryAfter * 1000
			req.on 'success', (data, response) ->
				data.leasedUntil = new Date data.leasedUntil
				expiry = data.leasedUntil.getTime() - Date.now()
				service.logger.info '[habakuk] leased credentials for %d seconds', (expiry / 1000).toFixed 0
				clearTimeout timeout if timeout
				timeout = setTimeout clearCredentials, expiry
				resolve data.credentials

	logger: console
	get: ->
		loadCredentials() unless credentials
		credentials

module.exports = service
