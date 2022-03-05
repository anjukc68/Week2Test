WITH RECURSIVE part1 AS (

  SELECT company, LEFT(fiscal_year::TEXT,4)::INT AS yr FROM dividend
)
 ,part2 AS (
  SELECT part1.company, part1.yr, 1 AS cs 
   FROM part1
  UNION DISTINCT
  SELECT part1.company, part1.yr, part2.cs + 1 
   FROM part1
   JOIN part2 
     ON part1.company = part2.company
    AND part1.yr = part2.yr + 1
)
SELECT jsonb_agg(DISTINCT company)  FROM part2  
WHERE cs >= 3; 

