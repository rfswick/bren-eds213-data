-- Exporting data from a database

-- The whole database
EXPORT DATABASE 'export_adsn'; ALTER

-- One table
COPY Species TO 'species_test.csv' (HEADER, DELIMITER ',');

-- Specific query
COPY (SELECT COUNT(*) FROM Species) TO 'species_count.csv' (HEADER, DELIMITER ',');

-- Inserting data
-- This is a fragile statement, because we are assuming the order of the columns
INSERT INTO Species VALUES ('abcd', 'thing', 'scientific_name', NULL);
SELECT * FROM Species

-- You can explicitly label columns
-- This is a much better way to code because it does not rely on the order of the columns.
-- It is far less fragile, it does not matter on the order of the database columns
INSERT INTO Species
    (Common_name, Scientific_name, Code, Relevance)
    VALUES
    ('thing 2', ' another scientific name', 'efgh', NULL);
    SELECT * FROM Species;

-- Can take advantage of default values
INSERT INTO Species
    (Common_name, Code)
    VALUES('thing 3', 'ijkl');
    SELECT * FROM Species;

-- UPDATES and DELETES will demolish the entire tables unless limited by WHERE
-- Strategies to avoid deleting your whole database
-- Doing a SELECT first
SELECT * FROM Bird_eggs WHERE Nest_ID LIKE 'z%';
SELECT * FROM Bird_nests;
-- Try the create a copy of the table
CREATE TABLE nest_temp AS (SELECT * FROM Bird_nests);
DELETE FROM nest_temp WHERE Site = 'chur';

-- other ideas
xDELETE FROM .... WHERE ....;

