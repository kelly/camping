module.exports = 	
	SCRAPE_URL               : 'http://www.reserveamerica.com'
	SCRAPE_CAMPSITE_RESOURCE : 'campsiteSearch.do'
	SCRAPE_DATE_FIELD_ID     : '#campingDate'
	SCRAPE_LENGTH_FIELD_ID   : '#lengthOfStay'
	SCRAPE_SUBMIT_ID         : '#search_avail'
	SCRAPE_LOAD_TIME         : 5000
	SCRAPE_RESULT_SELECTOR   : '.matchSummary'
	SCRAPE_ROW_SELECTOR      : '#shoppingitems tbody tr'
	SCRAPE_ADA_SELECTOR      : "img[title='Accessible']"
	SCRAPE_ROW_AVAIL_SELECTOR: 'a.book'
	SCRAPE_DATE_FORMAT       : 'ddd MMM D YYYY'

	MAILGUN_API_KEY          : 'mailgun-key'
	MAILGUN_EMAIL            : 'mailgun-email@email.com'
	EMAIL_DEFAULT            : 'me@mail.com'

	PARKS_DEFAULT_CONTRACT_CODE: 'CA'
	PARKS:
		'salt point':
			parkId: '120080'
			contractCode: 'CA'
		,
		'big sur':
			parkId: '120068'
			contractCode: 'CA'
		,
		'big basin': 
			parkId: '120009'
			contractCode: 'CA'
		,
		'mt diablo':
			parkId: '120061'
			contractCode: 'CA'
		,
		'steep ravine':
			parkId: '120063'
			contractCode: 'CA'
		,
		'china camp':
			parkId: '120063'
			contractCode: 'CA'
		,
		'china camp':
			parkId: '120063'
			contractCode: 'CA'
		,
		'calaveras big trees':
			parkId: '120014'
			contractCode: 'CA'