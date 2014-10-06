#!/usr/bin/env bash

echo "source /vagrant/schema.sql" | mysql -uroot -pyourpassword yourdbname
