CREATE TABLE Snow_cover (
    Site VARCHAR NOT NULL,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1990 AND 2018),
    Date DATE NOT NULL,
    Plot VARCHAR NOT NULL,
    Location VARCHAR NOT NULL,
    Snow_cover REAL CHECK (Snow_cover BETWEEN 0 AND 130),
    Water_cover REAL CHECK (Water_cover BETWEEN 0 AND 130),
    Land_cover REAL CHECK (Land_cover BETWEEN 0 AND 130),
    Total_cover REAL CHECK (Total_cover BETWEEN 0 AND 130),
    Observer VARCHAR,
    Notes VARCHAR,
    PRIMARY KEY (Site, Date, Plot, Location),
    FOREIGN KEY (Site) REFERENCES Site (Code)
);

-- Copy data from csv file into table we created
COPY Snow_cover FROM "ASDN_csv/snow_survey_fixed.csv" (header TRUE, nullstr "NA");

-- View data
SELECT * FROM Snow_cover LIMIT 10;

-- SQL does not know anything about NAs 
-- We need to set what the NA string is when we copy over the data into our SQL table

-- Ask 1: What is the average snow cover at each site?

SELECT Site, AVG(Snow_cover)
FROM Snow_cover
GROUP BY Site;

-- Ask 2: Top 5 most snowy sites

SELECT Site, AVG(Snow_cover) AS Avg_snowcover
FROM Snow_cover
GROUP BY Site
ORDER BY Avg_snowcover DESC
LIMIT 5; 

-- Ask 3: Save this as a view

CREATE VIEW Site_avg_snowcover AS (
    SELECT Site, AVG(Snow_cover) AS Avg_snowcover
    FROM Snow_cover
    GROUP BY Site
    ORDER BY Avg_snowcover DESC
    LIMIT 5 
);

-- View table
SELECT * FROM Site_avg_snowcover;

-- Now store it as a table
CREATE TEMP TABLE Site_avg_snowcover_table AS (
    SELECT Site, AVG(Snow_cover) AS Avg_snowcover
    FROM Snow_cover
    GROUP BY Site
    ORDER BY Avg_snowcover DESC
    LIMIT 5 
);

-- View temp table
SELECT * FROM Site_avg_snowcover_table;

-- DANGER ZONE AKA updating data
-- We found that 0s at Plot = `brw0` with snow_cover == 0 are actually no data (NULL)

CREATE TEMP TABLE Snow_cover_backup AS (SELECT * FROM Snow_cover);
UPDATE Snow_cover SET Snow_cover = NULL WHERE Plot = 'brw0' AND Snow_cover = 0;

-- Check that it worked before running the query on the real table
SELECT * FROM Snow_cover WHERE Plot = 'brw0';

-- Lets see if our view and temp table updated after this change to our data 
--VIEW
SELECT * FROM Site_avg_snowcover;

-- TEMP TABLE
SELECT * FROM Site_avg_snowcover_table;

-- The view table updated, but the temp table did not