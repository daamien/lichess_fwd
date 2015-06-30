
-- Load The Allmighty Multicorn
CREATE EXTENSION multicorn;

-- Load the Lichess Wrapper
CREATE SERVER lichess_fdw 
FOREIGN DATA WRAPPER multicorn
options (
  wrapper 'lichessfdw.LichessFDW'
);

-- Let's put everything in a separate schema
CREATE SCHEMA IF NOT EXISTS lichess;

-- 
-- This table will contains the game of the specified user
--
-- Note : the Lichess API seems to be limited to 200 results max.
--
CREATE FOREIGN TABLE lichess.games (
	id TEXT,
	variant TEXT,
        speed TEXT,
        perf TEXT,
	rated TEXT,
	status TEXT,
	clock TEXT,
	timestamp TEXT,
	turns TEXT,
	url TEXT,
	winner TEXT,
	players TEXT,
        analysis  TEXT,
        moves TEXT,
        opening TEXT
) SERVER lichess_fdw 
  options ( 
	username 'daamien' 
);



--
-- Quick 'n Dirty SQL request to calculate the winning ratio of the player when s/he chooses Caro-Kann as black
--
SELECT  
	100 * SUM( CASE WHEN winner='black' THEN 1 ELSE 0 END) / COUNT(winner)::float AS winning_rate 
FROM 
	lichess.games 
WHERE
	 opening ILIKE '%Caro-Kann%' 
     AND players ILIKE '%black%daamien%'
;


--
-- Remove comments below to clean up after the test
--

-- DROP SCHEMA lichess CASCADE;

-- DROP SERVER lichess_fdw CASCADE;

-- DROP EXTENSION multicorn;
