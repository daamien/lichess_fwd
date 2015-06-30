# Lichess FDW

A PostgreSQL Foreign Data Wrapper for Lichess

## INSTALL

First you need a basic environment :

- Install PostgreSQL : https://wiki.postgresql.org/wiki/Detailed_installation_guides
- Install multicorn : http://multicorn.readthedocs.org/en/latest/installation.html

Then install the lichess foreign data wrapper :

```
   git clone  https://github.com/daamien/mailchimp_fdw
   cd mailchimp_fdw
   sudo python setup.py install
   sudo service postgresql restart
```

## USE

```sql
   CREATE EXTENSION multicorn;
   CREATE SERVER lichess_fdw 
      FOREIGN DATA WRAPPER multicorn options ( wrapper 'lichessfdw.LichessFDW');
   CREATE FOREIGN TABLE games ( url TEXT, moves TEXT )
      SERVER lichess_fdw  options ( username 'chuck_norris' );
   SELECT COUNT(*) FROM games;
```

Check out the  ``games.example.sql`` file for an advanced example.

## Developper notes

This is a basic proof of concept based on the ``game`` function of the Lichess API (https://github.com/ornicar/lila#http-api).

This first version should be very easy to extend to other functions of the API. 

Furthermore PostgreSQL has a native JSON datatype and should be able to parse the analysis data and game moves very easily.

Any contribution to this tiny piece of software is more than wecome !

Long Live Lichess \o/
