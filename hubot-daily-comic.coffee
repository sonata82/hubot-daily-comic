# Description:
#   hubot-daily-comic
#
# Dependencies:
#   "daily-comic": "0.0.4"
#
# Configuration:
#   None
#
# Commands:
#   hubot show me dilbert - gets the daily dilbert
#   hubot show me xkcd - gets the daily xkcd
#
# Author:
#   Remko Plantenga <sonata82@gmail.com>

DailyComic = require "daily-comic.js"

comic = new DailyComic  updateInterval: 3600 * 6, subscriptions: [ "xkcd", "dilbert" ]

module.exports = (robot) ->
  robot.respond /((show|fetch)( me )?)?(xkcd|dilbert)/i, (msg) ->
    name = msg.match[4]
    cmc = comic.get name
    if cmc
      msg.send cmc.url
    else
      msg.send "error while trying to retrieve #{ name } comic"