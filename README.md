hubot-daily-comic
=================
A hubot script that will automatically fetch the daily Dilbert and xkcd and announce the urls in a configured list of
rooms.

[![Build Status](https://travis-ci.org/sonata82/hubot-daily-comic.svg)](https://travis-ci.org/sonata82/hubot-daily-comic)
[![Coverage Status](https://coveralls.io/repos/sonata82/hubot-daily-comic/badge.svg?branch=master)](https://coveralls.io/r/sonata82/hubot-daily-comic?branch=master)

Installing
----------
Add using npm

    npm install hubot-daily-comic

Or via the `package.json`:

     "dependencies": {
           ... 
           "hubot-daily-comic": "latest",
           ...
    }

then be sure to add to your `external-scripts.json`:

    [
        ...
        "hubot-daily-comic",
        ...
    ]

Configuration
-------------

HUBOT_ANNOUNCE_ROOMS - A comma separated list of rooms to announce new comics
HUBOT_DAILY_COMIC_INTERVAL - Number of seconds between checking for new comics (default is 6 hours)
