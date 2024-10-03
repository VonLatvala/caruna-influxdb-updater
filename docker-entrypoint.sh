#!/bin/bash

[[ -z $DELAY_SEC ]] && DELAY_SEC=$(( 60*30 )) # defaults to 30min

log() {
    echo "[$(date "+%d.%m.%Y %H:%M:%S")] $*"
}

log "Caruna update timer booting up"

log "Changing directory to solution directory"
cd /solution

log "Activating virtual environment"
. .venv/bin/activate

# Crash hard and loud on problem
set -eu

log "Starting main loop"
while [ true ]; do
    log "Running updater"
    ./update_influxdb.sh
    if [[ $? -ne 0 ]]; then
        exit 1
    fi
    log "Done running updater. Sleeping for ${DELAY_SEC}s"
    sleep $DELAY_SEC
done

log "Exiting (?)"
