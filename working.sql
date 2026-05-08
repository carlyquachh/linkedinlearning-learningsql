-- DATA FROM A DATABASE
  /* SELECT function: tells the database we want some information returned */
    -- SELECT 'Hello, World';

    -- SELECT first_name FROM people;
    -- vs
    -- SELECT 'first_name' FROM people;

    -- Output based on order called in statement
      -- SELECT first_name, last_name FROM people;
      -- SELECT first_name, state_code, company FROM people;
      -- SELECT company, first_name, quiz_points FROM people;

  /* WHERE function: adding selection criteria to a statement */
    -- SELECT * FROM people WHERE state_code = 'CA';
    -- SELECT * FROM people WHERE state_code = 'WA';

    -- SELECT * FROM people WHERE shirt_or_hat = 'shirt';
    -- vs
    -- SELECT * FROM people WHERE shirt_or_hat = 'jacket';

  -- VALID SQL MUST FOLLOW THIS ORDER OF CLAUSES:
    /*
    SELECT first_name, last_name, shirt_or_hat
    FROM people
    WHERE shirt_or_hat = 'shirt';
    */

    -- can use = or IS and != or IS NOT
    /*
    SELECT team, first_name, last_name
    FROM people
    WHERE shirt_or_hat = 'shirt'
    AND state_code = 'CA'
    AND team != 'Angry Ants';

    SELECT state_code, shirt_or_hat, first_name, last_name
    FROM people
    WHERE shirt_or_hat = 'shirt'
    AND (state_code = 'CA'
    OR state_code = 'CO');
    */

  -- LIKE %: ignores values after % (case insensitive)
    /*
    SELECT * FROM people
    WHERE state_code LIKE 'C%';

    SELECT * FROM people
    WHERE state_code LIKE '%N';

    SELECT * FROM people
    WHERE first_name LIKE '%on%';

    SELECT * FROM people
    WHERE company LIKE '%LLC';
    */

  -- LIMIT x: only shows x amount of records specified
    /*
    SELECT * FROM people
    WHERE company LIKE '%LLC'
    LIMIT 5;
    */

  -- ORDER BY field1, field2,... = defines what the database should sort by (default = ASCENDING (ASC), DESCENDING = DESC)
    /*
    SELECT first_name, last_name
    FROM people
    ORDER BY first_name;

    SELECT state_code, last_name, first_name
    FROM people
    ORDER BY state_code, last_name DESC;
    */

  -- Finding more information about the data
    -- LENGTH() counts character length
    /*
    SELECT first_name, LENGTH(first_name)
    FROM people;

    SELECT DISTINCT(shirt_or_hat)
    FROM people;

    SELECT DISTINCT(first_name)
    FROM people
    ORDER BY first_name;
    */

    -- COUNT() counts records that match condition
    /*
    SELECT COUNT(state_code)
    FROM people
    WHERE state_code = 'CA';
    */

    -- CODE CHALLENGE:
    /*
    SELECT team, shirt_or_hat, first_name, last_name
    FROM people
    WHERE state_code = 'CO'
    ORDER BY team, shirt_or_hat, last_name DESC;
    */

-- DATA FROM 2+ TABLES

  -- JOIN: asks for records across two tables that are associated with each other based on a common piece of information
    /*
    SELECT first_name, state_code
    FROM people
    JOIN states ON people.state_code = states.state_abbrev;

    SELECT *
    FROM people
    JOIN states ON people.state_code = states.state_abbrev
    WHERE people.first_name LIKE 'J%' AND states.region = 'South';

    SELECT ppl.first_name, st.state_name
    FROM people ppl, states st
    WHERE ppl.state_code = st.state_abbrev;
    */

  -- CROSS JOIN: returns every combination of rows from both tables
  -- (INNER) JOIN: returns rows where a specified condition matches between the two tables
  -- LEFT/RIGHT (OUTER) JOIN: returns all rows from the left/right table, plus matching rows from the right/left table (unmatched right-side rows are filled with NULL)
  -- FULL (OUTER) JOIN: gives matched and unmatched records from both tables
    /*
    SELECT ppl.first_name, ppl.last_name, ppl.state_code, st.state_name
    FROM states st
    JOIN people ppl ON ppl.state_code = st.state_abbrev;

    SELECT DISTINCT(ppl.state_code), st.state_abbrev
    FROM states st
    LEFT JOIN people ppl ON ppl.state_code = st.state_abbrev
    ORDER BY ppl.state_code;
    */

  -- GROUP BY: groups rows that share the same value in specified column(s) so aggregate functions like SUM, COUNT, or AVG can be applied to each group

    /*
    SELECT first_name, COUNT(first_name)
    FROM people
    GROUP BY first_name;

    SELECT state_code, COUNT(state_code)
    FROM people
    GROUP BY state_code;

    SELECT state_code, quiz_points, COUNT(quiz_points)
    FROM people
    GROUP BY state_code, quiz_points;
    */

  -- CODE CHALLENGE
  /*
  SELECT st.region, ppl.team, COUNT(team)
  FROM states st
  JOIN people ppl ON st.state_abbrev = ppl.state_code
  GROUP BY st.region, ppl.team;
  */

-- Data Types, Math, and Helpful Features
    /*
    SELECT 4 + 2;

    -- Division in integer space
    SELECT 1 / 3;
    -- Division in floating point space
    SELECT 1/ 3.0;
    */

    -- Boolean return 0 = F, 1 = T
    /*
    SELECT 3 > 2;
    SELECT 5 != 5;

    SELECT first_name, quiz_points
    FROM people
    WHERE quiz_points >= 65
    ORDER BY quiz_points;
    */

    -- MAX() / MIN(): aggregate function returns max/min in specified field
    /*
    SELECT MAX(quiz_points), MIN(quiz_points)
    FROM people;
    */
    -- SUM(): aggregate function returns sum of all values in specified field
    /*
    SELECT SUM(quiz_points)
    FROM people;
    */

    -- AVG(): aggregate function returns average of all values in a specified field
    /*
    -- NOTE: DONT TRY TO CALCULATE MATH YOURSELF (might have unexpected rounding issues)
    SELECT team, COUNT(*), SUM(quiz_points), SUM(quiz_points)/COUNT(*)
    FROM people
    GROUP BY team;

    -- INSTEAD:
    SELECT team, COUNT(*), SUM(quiz_points), AVG(quiz_points)
    FROM people
    GROUP BY team;
    */

    -- SUBSELECTING:
    -- MAX() does not work within a WHERE clause unless done in this way
    /*
    SELECT first_name, last_name, quiz_points
    FROM people
    WHERE quiz_points = (SELECT MAX(quiz_points) FROM people);

    SELECT *
    FROM people
    WHERE state_code = (SELECT state_abbrev FROM states WHERE state_name = 'Kansas');
    */

  -- Transforming Data
    /*
    SELECT LOWER(first_name), UPPER(last_name)
    FROM people;

    SELECT first_name, SUBSTR(last_name, 1, 5)
    FROM people;

    SELECT first_name, SUBSTR(last_name, -4)
    FROM people;

    -- replacements are case sensitive
    SELECT REPLACE(first_name, 'a', '-')
    FROM people;

    -- 1 comes before 6 and so on
    SELECT quiz_points
    FROM people
    ORDER BY CAST(quiz_points AS CHAR);

    SELECT MAX(CAST(quiz_points AS CHAR))
    FROM people;
    -- VS
    SELECT MAX(CAST(quiz_points AS INT))
    FROM people;
    */

    -- Creating Aliases w/ AS
    /*
    SELECT first_name as firstname, UPPER(last_name) AS surname
    FROM people
    WHERE firstname = 'Laura';
    */

    -- CODE CHALLENGE:
    /*
    SELECT st.state_name, MAX(ppl.quiz_points) AS maxpoints, AVG(ppl.quiz_points) AS avgpoints
    FROM people ppl
    JOIN states st ON ppl.state_code = st.state_abbrev
    GROUP BY ppl.state_code
    ORDER BY avgpoints DESC;
    */

-- ADD/MODIFY DATA

  -- INSERT: adds a record to a table
  /*
  INSERT INTO people (first_name) VALUES ('BOB');
  SELECT * FROM people;

  INSERT INTO people (first_name, last_name, state_code, city, shirt_or_hat, quiz_points)
  VALUES ('Mary', 'Hamilton', 'OR', 'Portland', 'hat', 95);
  SELECT * FROM people;

  INSERT INTO people (first_name, last_name)
  VALUES ('Katelyn', 'Ma'), ('Constance', 'Liu'), ('Vivian', NULL);
  SELECT * FROM people;
  */

  -- UPDATE: changes data stored in fields in a record
  /*
  UPDATE people
  SET last_name = 'Morrison'
  WHERE id_number = 175;

  SELECT *
  FROM people
  WHERE last_name = 'Morrison';
  */

  -- DELETE: removing a row of data
  /*
  SELECT *
  FROM people
  WHERE last_name IS NULL;
  DELETE FROM people
  WHERE last_name IS NULL;

  DELETE FROM people
  WHERE team IS NULL;
  SELECT *
  FROM people
  WHERE team IS NULL;
  */

  -- CODE CHALLENGE:
  /*
  SELECT id_number, first_name, state_code, team
  FROM people
  WHERE first_name = 'Alice' AND state_code = 'FL' AND team LIKE '%Cobras';
  */


















