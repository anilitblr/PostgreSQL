# Setup a local (development) PostgresSQL database

# Install PostgresSQL

#### Create the file repository configuration
```
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
```

#### Update the package lists
```
sudo apt-get update;
```

#### Install PostgresSQL
- Change the version number to install different version of PostgreSQL
- Exmaple, to install PostgreSQL 15 change `postgresql-14` to `postgresql-15`
```
sudo apt-get -y install postgresql-14 postgresql-client-14; 
```

# Service management

#### Enable service during boot up
```
sudo systemctl enable postgresql.service;
```

#### Stop service
```
sudo systemctl stop postgresql.service;
```

#### Start service
```
sudo systemctl start postgresql.service;
```

#### Restart service
```
sudo systemctl restart postgresql.service;
```

# Create a role and database

#### Create a role
```
sudo -u postgres psql -c "CREATE ROLE ex WITH PASSWORD 'pass.word';"
```

#### Drop database
```
sudo -u postgres psql -c "DROP database example-db;"
```

#### Create database
```
sudo -u postgres psql -c "CREATE DATABASE example-db WITH OWNER=ex;"
```

#### Grant privileges to database
```
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE example-db to ex;"
```

#### Create .pgpass file for passwordless connection
```
echo "
#hostname:port:database:username:password
localhost:5432:example-db:ex:pass.word" | tee ~/.pgpass
```

#### Change .pgpass file permission
```
chmod 600 ~/.pgpass
```

# Backup database

#### Backup database
```
pg_dump -h localhost -p 5432 -d example-db -U ex -w | gzip > example-db.sql.gz
```
# Restore database

#### Extract .gz file
```
gunzip example-db.sql.gz
```

#### Restore database
```
/usr/bin/psql -h localhost -p 5432 -U ex -w -d example-db < example-db.sql > restore-db.log 2>&1 && grep -i error restore-db.log;
```
