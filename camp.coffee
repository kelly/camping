_           = require 'underscore'
config      = require './config'
url         = require 'url'
moment      = require 'moment'
Nightmare   = require 'nightmare'
querystring = require 'querystring'
CronJob     = require('cron').CronJob
Mailgun     = require('mailgun').Mailgun

camping = 
	scrapeSites:(params, callback) ->
		_.defaults params,
			lengthOfStay : '1'
		console.log params
		Nightmare()
			.goto(@_siteUrl(parkId: params.parkId, contractCode: params.contractCode))
			.type(config.SCRAPE_DATE_FIELD_ID, params.campDate)
			.type(config.SCRAPE_LENGTH_FIELD_ID, params.lengthOfStay)
			.click(config.SCRAPE_SUBMIT_ID)
			.wait(config.SCRAPE_LOAD_TIME)
			.evaluate((config) ->
				summary = document.querySelector(config.SCRAPE_RESULT_SELECTOR).innerHTML
				siteCount = parseInt(summary.split(' ')[0])

				# filter sites
				[].map.call document.querySelectorAll(config.SCRAPE_ROW_SELECTOR), (row) ->

					# remove ada 
					adaEl = row.querySelectorAll(config.SCRAPE_ADA_SELECTOR)
					buttonEl = row.querySelectorAll(config.SCRAPE_ROW_AVAIL_SELECTOR)
					if (adaEl.length > 0 && buttonEl.length > 0) then siteCount -= 1

					# todo: remove group sites
				return siteCount
			, config)
			.end()
			.then((siteCount) -> 
				callback(siteCount)
				done()
			)

	findSitesAtPark: (park, date, callback) ->
		park = @_parsePark park
		formattedDate = @_formatDate date
		params = _.extend park, campDate: formattedDate

		@scrapeSites params, (siteCount) =>
			callback siteCount, formattedDate

	notifyWhenSiteAvailableAt: (park, date, email = config.EMAIL_DEFAULT, debug = false) ->
		park = @_parsePark park
		job = new CronJob
			cronTime: '*/5 * * * *'
			onTick: =>
				@findSitesAtPark park, date, (siteCount, date) =>
					if (debug) then console.log "sites: #{siteCount}"
					if (siteCount > 0) 
						@_notify email, 
							url      : @_siteUrl park
							date     : date
							siteCount: siteCount

						job.stop()						

			start: false
			timeZone: "America/Los_Angeles"
		
		job.start()

	_formatDate: (date) ->
		if (date == undefined) then date = moment(Date.now()).weekday(6);
		date = if (date instanceof Date || date instanceof String || typeof date == 'string') then moment(date) else date

		return date.format(config.SCRAPE_DATE_FORMAT)

	_parsePark: (park) ->
		if (park['parkId'] && park['contractCode']) then return park

		_.each config.PARKS, (val, key) -> 
			if (key == park) then park = val
		
		if (!park.parkId) then park = parkId: park, contractCode: config.PARKS_DEFAULT_CONTRACT_CODE

		return park

	_siteUrl: (park) ->
		return url.resolve(config.SCRAPE_URL, config.SCRAPE_CAMPSITE_RESOURCE) + '?' + querystring.stringify(park)

	_notify: (email, options) ->
		msg = "#{options.siteCount} campsite(s) available for #{options.date}";
		if (config.MAILGUN_API_KEY) 
			mg = new Mailgun(config.MAILGUN_API_KEY)
			mg.sendText config.MAILGUN_EMAIL, email, msg, options.url
		else
			console.log msg
		

module.exports = camping