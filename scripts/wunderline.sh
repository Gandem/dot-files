#!/usr/bin/env bash

nbTerminals=$(( $(ps aux | grep "login -pf" |  wc -l) - 1 ))

if [[ $nbTerminals -le 1 ]];
then wunderline all;
fi
