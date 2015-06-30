# Lichess FDW

A PostgreSQL Foreign Data Wrapper for Lichess

## INSTALL

First you need a basic environment :

- Install PostgreSQL : https://wiki.postgresql.org/wiki/Detailed_installation_guides
- Install multicorn : http://multicorn.readthedocs.org/en/latest/installation.html

Then install the lichess foreign data wrapper

'''
  git clone  https://github.com/daamien/mailchimp_fdw
  cd mailchimp_fdw
  sudo python setup.py install
  sudo service postgresql restart
'''

## USE

Check out the games.example.sql file for a basic example.
