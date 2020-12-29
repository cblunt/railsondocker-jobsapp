#!/bin/sh

rm -fv tmp/pids/server*.pid
bin/rails server -b 0.0.0.0 -p $PORT --pid tmp/pids/server.`hostname`.pid
