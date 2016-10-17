require('coffee-script');
require('coffee-script/register');

var camp, campNotify, opts, stdio, _;
_     = require('underscore');
camp  = require('../camp');
stdio = require('stdio');


opts = stdio.getopt({
  'park': {
    description: 'parkId, or salt point, big sur, big basin',
    mandatory: true,
    args: 1
  },
  'date': {
    description: 'date',
    args: 1
  },
  'email': {
    description: 'email',
    args: 1
  }
});

campNotify = function(opts) {
  return camp.notifyWhenSiteAvailableAt(opts.park, opts.date, opts.email);
};

campNotify(opts);

module.exports = campNotify;
