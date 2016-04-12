#!/bin/bash

PS=/bin/ps
AWK=/bin/awk
KILL=/bin/kill
HEAD=/usr/bin/head
GREP=/bin/grep

## Find the PID of unicorn master process
pid=`$PS -ef | $GREP unicorn | $GREP -v grep | $GREP master|$AWK '{print $2}'| $HEAD -1`

##Kill the unicorn process

if [ ! -z $pid ]; then
  $KILL -9 $pid
fi

pid1=`$PS -ef | $GREP unicorn | $GREP -v grep | $GREP master|$AWK '{print $2}'| $HEAD -1`

###Resteart the Unicorn process

if [ -z $pid1 ]; then
  /usr/local/bin/unicorn  -D -c /var/www/simple-sinatra-app/unicorn.conf.rb
fi
