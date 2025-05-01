.table

-- There are lots of "dot-commands" in DuckDB
.help
.help show
.show
-- .exit will exit DuckDB, or Ctrl-D

-- Start with SQL
SELECT * FROM Site;
-- SQL is case-insensitive, but uppercase is the tradition
select * from site;

-- can be combined with OFFSET clause
SELECT * FROM Site
    LIMIT 3
    OFFSET 3;

-- Selecting distinct items
SELECT * FROM bird_nests LIMIT 1;
SELECT Species FROM Bird_nests;
SELECT DISTINCT Species FROM Bird_nests;
SELECT DISTINCT Species, Observer FROM Bird_nests;

-- add ordering
SELECT DISTINCT Species, Observer 
    FROM Bird_nests
    ORDER BY Species;

SELECT DISTINCT Species, Observer 
    FROM Bird_nests
    WHERE Species == 'wrsa'
    ORDER BY Species;

-- Select distinct locartions from the SITE table
-- ARE they returned in order? If not, order them
-- Then, add a LIMIT clause to just return 3 results
-- Q: was the LIMIT applied *before* the results were ordered, or *after*?
SELECT DISTINCT Location 
    FROM Site
    ORDER BY Location
    LIMIT 3;