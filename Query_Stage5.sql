/*
START STAGE 5
*/
SELECT DISTINCT s.name
FROM Spray s
JOIN Painting p ON s.id = p.spray_id
WHERE s.color = 'R'
  AND s.id IN (
        SELECT p1.spray_id
        FROM Painting p1
        GROUP BY p1.spray_id
        HAVING COUNT(*) > 1
  )
  AND p.square_id IN (
        SELECT p2.square_id
        FROM Painting p2
        JOIN Spray s2 ON s2.id = p2.spray_id
        WHERE s2.color = 'B'
  )
ORDER BY s.name;
/*
END STAGE 5
*/

/*
Other Solution: Using CTEs
--
WITH red_used_more_than_once AS (
    SELECT p.spray_id
    FROM Painting p
    JOIN Spray s ON s.id = p.spray_id
    WHERE s.color = 'R'
    GROUP BY p.spray_id
    HAVING COUNT(*) > 1
),
blue_squares AS (
    SELECT DISTINCT p.square_id
    FROM Painting p
    JOIN Spray s ON s.id = p.spray_id
    WHERE s.color = 'B'
)
SELECT DISTINCT s.name
FROM Spray s
JOIN Painting p ON s.id = p.spray_id
WHERE s.color = 'R'
  AND s.id IN (SELECT spray_id FROM red_used_more_than_once)
  AND p.square_id IN (SELECT square_id FROM blue_squares)
ORDER BY s.name;
 */

/*
Other Solution
--
SELECT DISTINCT s.name
FROM Spray AS s
JOIN Painting AS p
    ON s.id = p.spray_id
WHERE s.color = 'R'
  AND s.id IN (
        SELECT s1.id
        FROM Spray AS s1
        JOIN Painting AS p1
            ON s1.id = p1.spray_id
        WHERE s1.color = 'R'
        GROUP BY s1.id
        HAVING COUNT(*) > 1
  )
  AND p.square_id IN (
        SELECT p2.square_id
        FROM Painting AS p2
        JOIN Spray AS s2
            ON s2.id = p2.spray_id
        WHERE s2.color = 'B'
        GROUP BY p2.square_id
  )
ORDER BY s.name;
 */

/*
Other Solution
--

 */