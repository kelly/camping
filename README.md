# Camping ⛺️

Get an email notification when a campsite is available


## How does it work?

It checks recreation.gov campsite listings every 5 minutes to see if there is a new availability. There is typically a few cancelations two days before a camping reservations. Be the first to snag a site! 

## Install

````bash
$ npm install
````

edit config.coffee file with a mailgun API key. 


## Example Usage

````bash
$ node camp-notify --park 'big basin' --email 'jim@jimbo.com'
````


```
Usage: node camp-notify [options]

Options:

  --park    'parkId, or preset'
  --email   'jim@jimbo.com'
  --date    '08/08/16'
```


## Questions?

http://www.twitter.com/korevec
