#!/usr/bin/env bash

if [ -z "$1" ]
then
  clojure -A:test
else
  problem=`printf %02d $1`
  clojure -A:test -n "problems.problem-$problem-test"
fi