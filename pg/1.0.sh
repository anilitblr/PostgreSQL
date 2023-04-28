#!/bin/bash

# Variables
# ------------------------------------------------------------------------------
server=localhost
database=example-db
port=5432
username=ex

# Create tables:
echo "-- Create Tables --"
psql -h $server -p $port -U $username -d $database -w < ./data/pg/1.0/create_table.sql > db.log 2>&1 && grep ERROR db.log
