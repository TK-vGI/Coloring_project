/*
START STAGE 6
*/
SELECT s.name
FROM Square s
         JOIN Painting p
              ON s.id = p.square_id
WHERE p.spray_id IN (
    -- Subquery to find IDs of spray cans that are now empty
    SELECT spray_id
    FROM Painting
    GROUP BY spray_id
    HAVING SUM(volume) = 255)
GROUP BY s.id, s.name
HAVING SUM(p.volume) = 765
   AND COUNT(DISTINCT p.spray_id) = (
    -- Ensures the square was ONLY painted by the empty cans identified above
    SELECT COUNT(DISTINCT p2.spray_id)
    FROM Painting p2
    WHERE p2.square_id = s.id)
ORDER BY s.id;

/*
END STAGE 6
*/

/*
Other Solution CTEs
--
WITH empty_cans AS (
    -- Identify spray cans that are completely empty after all paintings.
    -- A spray can is empty if the TOTAL volume used across ALL squares = 255.
    SELECT spray_id
    FROM Painting
    GROUP BY spray_id
    HAVING SUM(volume) = 255
),

white_squares AS (
    -- Identify squares that are fully white.
    -- A square is white if the TOTAL volume painted on it = 765.
    SELECT square_id
    FROM Painting
    GROUP BY square_id
    HAVING SUM(volume) = 765
),

square_empty_sprays AS (
    -- For each square, list only the spray events that used empty cans.
    -- This filters Painting down to rows where spray_id is in empty_cans.
    SELECT p.square_id, p.spray_id, p.volume
    FROM Painting p
    JOIN empty_cans ON p.spray_id = empty_cans.spray_id
)

SELECT sq.name
FROM Square sq
JOIN square_empty_sprays ses
    ON sq.id = ses.square_id
WHERE sq.id IN (SELECT square_id FROM white_squares)
GROUP BY sq.id, sq.name
HAVING
    -- Ensure the square is white (sum of volumes = 765)
    SUM(ses.volume) = 765
    AND
    -- Ensure ALL sprays used on this square are empty.
    -- Compare:
    --   number of empty sprays used
    --   vs number of ALL sprays used on that square
    COUNT(DISTINCT ses.spray_id) = (
        SELECT COUNT(DISTINCT p2.spray_id)
        FROM Painting p2
        WHERE p2.square_id = sq.id
    )
ORDER BY sq.id;

 */

/*
Other Solution
--
WITH empty_cans AS (
    -- Spray cans that are fully empty (total volume = 255)
    SELECT spray_id
    FROM Painting
    GROUP BY spray_id
    HAVING SUM(volume) = 255
),
white_squares AS (
    -- Squares that are fully white (total volume = 765)
    SELECT square_id
    FROM Painting
    GROUP BY square_id
    HAVING SUM(volume) = 765
),
square_spray_counts AS (
    -- Total number of sprays used per square
    SELECT square_id, COUNT(DISTINCT spray_id) AS total_sprays
    FROM Painting
    GROUP BY square_id
),
square_empty_spray_counts AS (
    -- Number of empty sprays used per square
    SELECT p.square_id, COUNT(DISTINCT p.spray_id) AS empty_sprays
    FROM Painting p
    JOIN empty_cans ec ON p.spray_id = ec.spray_id
    GROUP BY p.square_id
)

SELECT sq.name
FROM Square sq
JOIN white_squares ws ON sq.id = ws.square_id
JOIN square_spray_counts sc ON sq.id = sc.square_id
JOIN square_empty_spray_counts esc ON sq.id = esc.square_id
WHERE sc.total_sprays = esc.empty_sprays
ORDER BY sq.id;
 */

/*
Other Solution
--

 */