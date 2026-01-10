/*
START STAGE 1
*/
SELECT s.id, s.name
FROM Square AS s
LEFT JOIN Painting AS p
    ON s.id = p.square_id
WHERE p.square_id IS NULL
ORDER BY s.name DESC;

/*
END STAGE 1
*/

/*
Other Solution
--
SELECT s.id,
       s.name
FROM Square s
WHERE s.id NOT IN
    (SELECT p.square_id
     FROM Painting p)
ORDER BY s.name DESC;
 */

/*
Other Solution
--
SELECT
    id,
    name
FROM
    Square
WHERE
    id NOT IN (
        SELECT
            square_id
        FROM
            Painting
    )
ORDER BY
    name DESC;
 */

/*
Other Solution
--
select
    s.id,
    s.name
from
    Square s
left join
    Painting p
on
    s.id = p.square_id
where
    p.square_id is null
order by
    s.name desc;
 */