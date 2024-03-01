#!/bin/sh
guix shell openjdk@17.0.5 \
     -- ~/Applications/neo4j/bin/neo4j-admin $@
